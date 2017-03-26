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
    
    //MARK: Child tables
    
    struct FirebaseChild {
        
        static let Settings = "settings"
        static let MenuGroups = "menu_groups"
        static let Dishes = "dishes"
        
    }
    
    //MARK: Firebase reference
    
    let ref = FIRDatabase.database().reference()
    
    //MARK: Functions
    
    internal func reloadFirebaseData(childName: String, callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        ref.child(childName).observeSingleEvent(of: .value, with: { (snapshot) in
            callback(snapshot)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    internal func getImageFromStorage(nameOfImage: String, callBack: @escaping (_ image: UIImage) -> ()) {
        
        let storage = FIRStorage.storage().reference()
        let tempImageRef = storage.child(nameOfImage)
        
        tempImageRef.data(withMaxSize: 1*500*300) { (data, error) in
            if error == nil {
                callBack(UIImage(data: data!)!)
            } else {
                print(error?.localizedDescription ?? "unhandled error")
            }
        }
        
    }
    
}
