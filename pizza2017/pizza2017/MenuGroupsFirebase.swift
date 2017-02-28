//
//  MenuGroupsFirebase.swift
//  pizza2017
//
//  Created by user on 24.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class MenuGroupsFirebase {
    static var taskMenuGroups: MenuGroupsModel?
    static var arrayOfTaskMenuGroups = [MenuGroupsModel]()
    static let ref = FIRDatabase.database().reference()
    static let storage = FIRStorage.storage()
    static let storageRef = storage.reference()
    
    static func getTasksFromFirebase() {
        ref.child("menu_groups").observeSingleEvent(of: .value, with: { (snapshot) in
            for items in snapshot.children {
                let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
                let key = tasksInFirebase["key"] as! String
                let name = tasksInFirebase["name"] as! String
                let photoName = tasksInFirebase["photoName"] as! String
                let photoUrl = tasksInFirebase["photoUrl"] as! String
                taskMenuGroups = MenuGroupsModel(key: key, name: name, photoName: photoName, photoUrl: photoUrl)
                arrayOfTaskMenuGroups.append(taskMenuGroups!)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
