//
//  HelperFirebase.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class SettingsFirebase {
    static var taskSettings: SettingsModel?
    static let ref = FIRDatabase.database().reference()
    
    static func getTasksFromFirebase(callback: @escaping ()->()){
        ref.child("settings").observeSingleEvent(of: .value, with: { (snapshot) in
            let tasksInFirebase = snapshot.value as! NSDictionary
            let address = tasksInFirebase["address"] as! String
            let email = tasksInFirebase["email"] as! String
            let latitude = tasksInFirebase["latitude"] as! Float
            let longitude = tasksInFirebase["longitude"] as! Float
            let phone = tasksInFirebase["phone"] as! String
            taskSettings = SettingsModel(address: address, email: email, latitude: latitude, longitude: longitude, phone: phone)
            callback()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

