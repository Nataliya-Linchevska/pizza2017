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
    
    static func getTasksFromFirebase(){
        ref.child("menu_groups").observeSingleEvent(of: .value, with: { (snapshot) in
            let tasksInFirebase = snapshot.value as! NSDictionary
            print(tasksInFirebase)
//            for groups in tasksInFirebase {
//                let key = tasksInFirebase["key"] as! String
//                print(key)
//                let name = tasksInFirebase["name"] as! String
//                print(name)
//                let photoName = tasksInFirebase["photoName"] as! String
//                print(photoName)
//                let photoUrl = tasksInFirebase["photoUrl"] as! String
//                print(photoUrl)
//                taskMenuGroups = MenuGroupsModel(key: key, name: name, photoName: photoName, photoUrl: photoUrl)
//                arrayOfTaskMenuGroups.append(taskMenuGroups!)
//                print(arrayOfTaskMenuGroups)
//            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
