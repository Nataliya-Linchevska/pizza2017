//
//  File.swift
//  pizza2017
//
//  Created by konstantin on 3/25/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelper {
    
    //MARK: Firebase references
    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    //MARK: Properties
    
    internal var databaseObserversRef = [FIRDatabaseReference : FIRDatabaseHandle?]()
    
    //MARK: Functions
    
    func getTableName() -> String {
        return ""
    }
    
    func getImageFolderName() -> String {
        return ""
    }
    
}

//MARK: Extension - Saving/Updating the data

extension FirebaseHelper {

    //MARK: Saving
    
    func saveObject(postObject: FirebaseDataProtocol?,
         callBack: @escaping (Error?, FIRDatabaseReference, FirebaseDataProtocol?) -> ()) {
        
        if postObject!.key.isEmpty {
            saveNewObject(postObject: postObject, callBack: callBack)
        } else {
            updateObject(postObject: postObject, callBack: callBack)
        }
    }
    
    //MARK: Removing
    
    func removeObjectByKey(_ key: String) {
        
        databaseRef.child(getTableName()).child(key).removeValue { (error, reference) in
            
            if let err = error {
                Loger.instance.writeToLog(err.localizedDescription)
            }
        }        
    }
    
    func removeObjectBySubKey(subKeyName: String, subKeyValue: String) {
        
        databaseRef.child(getTableName()).queryOrdered(byChild: subKeyName)
            .queryEqual(toValue: subKeyValue)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                for firebaseChildrens in snapshot.children {
                    
                    let childDict = (firebaseChildrens as! FIRDataSnapshot).value as! NSDictionary
                    let key = childDict["key"] as! String
                    self.removeObjectByKey(key)
                }
            }) { (error) in
                Loger.instance.writeToLog(error.localizedDescription)
        }
    }
    
    //MARK: Private Functions
    
    private func saveNewObject(postObject: FirebaseDataProtocol?,
        callBack: @escaping (Error?, FIRDatabaseReference, FirebaseDataProtocol?) -> ()) {
        
        guard postObject != nil else {
            return
        }
        
        var validObject = postObject!
        let ref = databaseRef.child(getTableName()).childByAutoId()
        validObject.key = ref.key        
        ref.setValue(validObject.getPostData(), withCompletionBlock: { (error, reference) in
            callBack(error, reference, postObject)
        })
    }
    
    private func updateObject(postObject: FirebaseDataProtocol?,
        callBack: @escaping (Error?, FIRDatabaseReference, FirebaseDataProtocol?) -> ()) {
        
        guard postObject != nil else {
            return
        }
        let ref = databaseRef.child(getTableName()).child(postObject!.key)
        ref.updateChildValues(postObject!.getPostData(), withCompletionBlock: { (error, reference) in
            callBack(error, reference, postObject)
        })
    }
    
}


//MARK: Extension - Work with firebase observe

extension FirebaseHelper {
    
    //MARK: Lisnteners
    
    internal func initObserve(callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        let obsRef = databaseRef.child(getTableName())
        let databaseHandle = obsRef.observe(FIRDataEventType.value, with: { (snapshot) in
            callback(snapshot)
        }) { (error) in
            Loger.instance.writeToLog(error.localizedDescription)
        }
        databaseObserversRef[obsRef] = databaseHandle
    }
    
    internal func initObserveBySubKey(subKeyName: String, subKeyValue: String, callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        let obsRefSub = databaseRef.child(getTableName())
        let databaseHandle = obsRefSub.queryOrdered(byChild: subKeyName)
            .queryEqual(toValue: subKeyValue).observe(.value, with: { (snapshot) in
                callback(snapshot)
            }) { (error) in
                Loger.instance.writeToLog(error.localizedDescription)
        }
        databaseObserversRef[obsRefSub] = databaseHandle
    }
    
    internal func deinitObserve() {
        
        for dbRef in databaseObserversRef {
            
            if let validHandle = dbRef.value {
                dbRef.key.child(getTableName()).removeObserver(withHandle: validHandle)
            } else {
                dbRef.key.child(getTableName()).removeAllObservers()
            }
        }
    }
    
}

//MARK: Extension - Work with firebase images

extension FirebaseHelper {
    
    internal func getImageFromStorage(nameOfImage: String, callBack: @escaping (_ image: UIImage) -> ()) {
        
        let tempImageRef = storageRef.child(getImageFolderName()).child(nameOfImage)
        
        tempImageRef.data(withMaxSize: 1*500*500) { (data, error) in
            if error == nil {
                callBack(UIImage(data: data!)!)
            } else {
                Loger.instance.writeToLog(error?.localizedDescription ?? "unhandled error")
            }
        }
    }
    
    internal func saveImageToFirebase(imageName: String, image: UIImage,
                                      callBack: @escaping (_ success: Bool, _ photoURL: URL?) -> ()) {
        
        let imageRef = storageRef.child(getImageFolderName()).child(imageName)
        if let userImage = image.compressImage(compressionQuality: 1) {
            imageRef.put(userImage, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    Loger.instance.writeToLog("Error while uploading file: \(imageName)")
                    callBack(false, nil)
                    return
                }
                callBack(true, metadata?.downloadURL())
            })
        }
    }
    
    internal func removeImageFromStorage(imageName: String) {
        
        storageRef.child(getImageFolderName()).child(imageName).delete { (error) in
            if error != nil {
                Loger.instance.writeToLog((error?.localizedDescription) ?? "Error while deleting file \(imageName)")
            }
        }        
    }
    
}
