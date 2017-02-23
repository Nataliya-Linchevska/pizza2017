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
    static let ref = FIRDatabase.database().reference()
    
    static func getTasksFromFirebase(keyWord: String){
        ref.child(keyWord).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print(snap)
////                    child.value["meanAcc"] as! String
                }
            } else {
                print("no results")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    
    }
}
