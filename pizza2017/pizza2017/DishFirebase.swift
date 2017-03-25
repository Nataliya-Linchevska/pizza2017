//
//  DishFirebase.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class DishesFirebase {
    static var taskDish: DishModel?
    static var arrayOfDish = [DishModel]()
    static var keyForDish: String = ""
    
    static let ref = FIRDatabase.database().reference()
    
    static func getTasksFromFirebase(callback: @escaping ()->()) {
        arrayOfDish.removeAll()
        ref.child("dishes").observeSingleEvent(of: .value, with: { (snapshot) in
            for items in snapshot.children {
                let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
                let name = tasksInFirebase["name"] as! String
                let description = tasksInFirebase["description"] as! String
                let price = tasksInFirebase["price"] as! Float
                let photoUrl = tasksInFirebase["photoUrl"] as! String
                let photoName = tasksInFirebase["photoName"] as! String
                let keyGroup = tasksInFirebase["keyGroup"] as! String
                let key = tasksInFirebase["key"] as! String
                taskDish = DishModel(name: name, description: description, price: price, photoUrl: photoUrl, photoName: photoName, keyGroup: keyGroup, key: key)
                
                if keyForDish == keyGroup {
                    arrayOfDish.append(taskDish!)
                }
            }
            callback()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
