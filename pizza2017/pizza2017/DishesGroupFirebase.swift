//
//  DishesGroupFirebase.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class DishesGroupFirebase {
    static var taskDishesGroups: DishesGroupModel?
    static var arrayOfDishesGroups = [DishesGroupModel]()
    static var keyForDish: String = ""
    
    static let ref = FIRDatabase.database().reference()
    
    static func getTasksFromFirebase(callback: @escaping ()->()) {
        arrayOfDishesGroups.removeAll()
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
                taskDishesGroups = DishesGroupModel(name: name, description: description, price: price, photoUrl: photoUrl, photoName: photoName, keyGroup: keyGroup, key: key)
                
                if keyForDish == keyGroup {
                    arrayOfDishesGroups.append(taskDishesGroups!)
                    print("MY KEY IS \(keyGroup)")
                    print(arrayOfDishesGroups)
                }
            }
            callback()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
