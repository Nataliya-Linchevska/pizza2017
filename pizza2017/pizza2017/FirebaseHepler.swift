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
    
    func getChildName() -> String {
        return ""
    }
    
    func getImageFolderName() -> String {
        return ""
    }
    
    internal func reloadData(callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        databaseRef.child(getChildName()).observeSingleEvent(of: .value, with: { (snapshot) in
            callback(snapshot)
        }) { (error) in
            Loger.instance.writeToLog(error.localizedDescription)
        }
    }
    
}

//MARK: Extension - Work with firebase observe

extension FirebaseHelper {
    
    //MARK: Functions
    
    internal func initObserve(callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        databaseHandle = databaseRef.child(getChildName()).observe(FIRDataEventType.value, with: { (snapshot) in
            callback(snapshot)
        }) { (error) in
            Loger.instance.writeToLog(error.localizedDescription)
        }
        
    }
    
    internal func deinitObserve() {
        
        if let validHandle = databaseHandle {
            databaseRef.child(getChildName()).removeObserver(withHandle: validHandle)
        } else {
            databaseRef.child(getChildName()).removeAllObservers()
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

//MARK: Extension - Child tables

extension FirebaseHelper {
    
    struct FirebaseChild {
        
        static let Courier = "courier"
        static let Deliveries = "deliveries"
        static let Dishes = "dishes"
        static let MenuGroups = "menu_groups"
        static let News = "news"
        static let ReservedTables = "reserved_tables"
        static let Settings = "settings"
        static let Tables = "tables"
        static let Topics = "topics"
        static let Users = "users"
        
    }
    
    struct FirebaseImageFolder {
        
        static let MenuGroups = "menu_group_images"
        static let Dishes = "dishes_images"
        static let News = "news_images"
        
    }
    
}
