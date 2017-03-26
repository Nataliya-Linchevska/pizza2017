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
    
    //MARK: Properties
    
    private var databaseHandle: FIRDatabaseHandle?
    
    //MARK: Functions
    
    func getChildName() -> String {
        
        return ""
        
    }
    
    internal func reloadFirebaseData(callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        ref.child(getChildName()).observeSingleEvent(of: .value, with: { (snapshot) in
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
    
    internal func initFirebaseObserve(callback: @escaping (_ snapshot: FIRDataSnapshot)->()) {
        
        databaseHandle = ref.child(getChildName()).observe(FIRDataEventType.value, with: { (snapshot) in
            callback(snapshot)
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    internal func deinitFirebaseObserve() {
        
        if let validHandle = databaseHandle {
            ref.child(getChildName()).removeObserver(withHandle: validHandle)
        } else {
            ref.child(getChildName()).removeAllObservers()
        }
        
        
    }
    
}
