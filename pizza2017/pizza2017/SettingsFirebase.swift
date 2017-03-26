//
//  HelperFirebase.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class SettingsFirebase: FirebaseHelper {
    
    //MARK: Firebase fields
    
    struct FirebaseFields {
        
        static let Adress = "address"
        static let Email = "email"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let Phone = "phone"
        
    }

    
    //MARK: Functions
    
    override func getChildName() -> String {
        
        return FirebaseHelper.FirebaseChild.Settings
        
    }
    
    func reloadSettings(callback: @escaping (_ settings: SettingsModel)->()){
        
        reloadFirebaseData{ (snapshot) in
            callback(self.getSettings(snapshot))
        }
    }
    
    func initFirebaseObserve(callback: @escaping (_ settings: SettingsModel)->()){
        
        super.initFirebaseObserve { (snapshot) in           
            callback(self.getSettings(snapshot))
        }
    }
    
    private func getSettings(_ snapshot: FIRDataSnapshot) -> SettingsModel {
        
        let tasksInFirebase = snapshot.value as! NSDictionary
        let address = tasksInFirebase[FirebaseFields.Adress] as! String
        let email = tasksInFirebase[FirebaseFields.Email] as! String
        let latitude = tasksInFirebase[FirebaseFields.Latitude] as! Float
        let longitude = tasksInFirebase[FirebaseFields.Longitude] as! Float
        let phone = tasksInFirebase[FirebaseFields.Phone] as! String
        
        return SettingsModel(address: address, email: email,
                             latitude: latitude, longitude: longitude, phone: phone)
    }
}

