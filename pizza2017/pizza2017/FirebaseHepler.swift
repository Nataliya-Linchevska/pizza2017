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
    
    internal var databaseHandle: FIRDatabaseHandle?
    
    
    //MARK: Functions
    
    func getTableName() -> String {
        return ""
    }
    
    func getImageFolderName() -> String {
        return ""
    }
    
    func reloadData(callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        databaseRef.child(getTableName()).observeSingleEvent(of: .value, with: { (snapshot) in
            callback(snapshot)
        }) { (error) in
            Loger.instance.writeToLog(error.localizedDescription)
        }
    }
    
    func getNewRecordKey() -> String {
        
        return databaseRef.child(getTableName()).childByAutoId().key
        
    }
    
    func saveObject(key: String, value: Any?) {
        
        databaseRef.child(getTableName()).child(key).setValue(value)
    }
    
}

//MARK: Extension - Work with firebase observe

extension FirebaseHelper {
    
    //MARK: Functions
    
    internal func initObserve(callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        databaseHandle = databaseRef.child(getTableName()).observe(FIRDataEventType.value, with: { (snapshot) in
            callback(snapshot)
        }) { (error) in
            Loger.instance.writeToLog(error.localizedDescription)
        }
        
    }
    
    internal func deinitObserve() {
        
        if let validHandle = databaseHandle {
            databaseRef.child(getTableName()).removeObserver(withHandle: validHandle)
        } else {
            databaseRef.child(getTableName()).removeAllObservers()
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
    
    internal func saveImageToStorage(imageName: String, localPath: String,
                                     callBack: @escaping (_ success: Bool, _ photoURL: URL?) -> ()) {
        
        let localFile = URL(string: localPath)!
        let childRef = storageRef.child(getImageFolderName()).child(imageName)
        let uploadTask = childRef.putFile(localFile, metadata: nil) { metadata, error in
            if let error = error {
                Loger.instance.writeToLog("Error while uploading file: \(localPath)")
                callBack(false, nil)
            } else {
                callBack(true, metadata!.downloadURL())
            }
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
