//
//  HelperFirebase.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class HelperFirebase {
    static var ref: FIRDatabaseReference!
    
//    static func getTasksFromFirebase(keyWord: String) {
//        ref = FIRDatabase.database().reference()
//        self.ref.child(keyWord).observeSingleEvent(of: .value, with: { (snapshot) in
//            for items in snapshot.children {
//                let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
//                //print(tasksInFirebase)
//                let adress = tasksInFirebase["adress"] as! String
//                print("_______________________")
//                print(adress)
//                //                let name = tasksInFirebase["name"] as! String
//                //                let checked = tasksInFirebase["checked"] as! Bool
//                //                let data = tasksInFirebase["data"] as! String
//                //                let task = TaskModel(name: name, checked: checked, data: data)
//                //                arrayOfTasks.append(task)
//            }
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
    
//    static func getTasksFromFirebase(keyWord: String){
//        ref = FIRDatabase.database().reference()
//        ref.child(keyWord).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                print("----------------")
//                print(result)
////                for child in result {
////                    print("----------------")
////                    print(child)/Users/user/Downloads/GoogleService-Info.plist
//////                    child.value["meanAcc"] as! String
////                }
//            } else {
//                print("no results")
//            }
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    
//    }
}
