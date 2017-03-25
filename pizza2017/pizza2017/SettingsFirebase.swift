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
    
    //MARK: Init singleton
    
    static var instance = SettingsFirebase()
    
    private override init(){}
    
    //MARK: Functions
    
    func reloadSettings(callback: @escaping (_ settings: SettingsModel)->()){
        
        reloadFirebaseData(childName: "settings") { (snapshot) in
            let tasksInFirebase = snapshot.value as! NSDictionary
            let address = tasksInFirebase["address"] as! String
            let email = tasksInFirebase["email"] as! String
            let latitude = tasksInFirebase["latitude"] as! Float
            let longitude = tasksInFirebase["longitude"] as! Float
            let phone = tasksInFirebase["phone"] as! String
            callback(SettingsModel(address: address, email: email, latitude: latitude, longitude: longitude, phone: phone))
        }
    }
}

