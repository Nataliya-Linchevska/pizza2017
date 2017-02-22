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
    
    static func getTasksFromFirebase(keyWord: String){
        let ref = FIRDatabase.database().reference()
        ref.child(keyWord).observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
                print("----------------")
                print(result)
//                for child in result {
//                    print("----------------")
//                    print(child)/Users/user/Downloads/GoogleService-Info.plist
////                    child.value["meanAcc"] as! String
//                }
            } else {
                print("no results")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    
    }
}
