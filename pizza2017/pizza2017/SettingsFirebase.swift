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
    
    //MARK: Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.Settings.TableName
        
    }
    
    func initFirebaseObserve(callback: @escaping (_ settings: SettingsModel)->()){
        
        super.initObserve { (snapshot) in
            callback(self.getSettings(snapshot))
        }
    }
    
    private func getSettings(_ snapshot: FIRDataSnapshot) -> SettingsModel {
        
        let tasksInFirebase = snapshot.value as! NSDictionary
        let address = tasksInFirebase[FirebaseTables.Settings.Child.Adress] as! String
        let email = tasksInFirebase[FirebaseTables.Settings.Child.Email] as! String
        let latitude = tasksInFirebase[FirebaseTables.Settings.Child.Latitude] as! Float
        let longitude = tasksInFirebase[FirebaseTables.Settings.Child.Longitude] as! Float
        let phone = tasksInFirebase[FirebaseTables.Settings.Child.Phone] as! String
        let adminEmail = tasksInFirebase[FirebaseTables.Settings.Child.AdminEmail] as! String
        
        return SettingsModel(address: address, email: email,
                             latitude: latitude, longitude: longitude, phone: phone, adminEmail: adminEmail)
    }
}

