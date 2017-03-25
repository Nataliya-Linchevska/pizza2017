//
//  DishesGroupFirebase.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class DishesGroupFirebase: FirebaseHelper {
    
    //MARK: Init singleton
    
    static var instance = DishesGroupFirebase()
    
    private override init(){}
    
    //MARK: Properties
    
    private var dishesGroups = [DishesGroupModel]()
    
    //MARK: Functions
    
    func reloadDishesGroup(dishKey: String, callback: @escaping ()->()) {
        
        dishesGroups.removeAll()
        
        reloadFirebaseData(childName: "dishes") { (snapshot) -> () in
            for items in snapshot.children {
                
                let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
                let keyGroup = tasksInFirebase["keyGroup"] as! String
                if keyGroup != dishKey {
                    continue
                }
                
                let name = tasksInFirebase["name"] as! String
                let description = tasksInFirebase["description"] as! String
                let price = tasksInFirebase["price"] as! Float
                let photoUrl = tasksInFirebase["photoUrl"] as! String
                let photoName = tasksInFirebase["photoName"] as! String
                let key = tasksInFirebase["key"] as! String
                
                self.dishesGroups.append(DishesGroupModel(name: name, description: description, price: price, photoUrl: photoUrl, photoName: photoName, keyGroup: keyGroup, key: key))
            }
            callback()
        }
        
    }
    
    func getDishesGroups() -> [DishesGroupModel] {
        
        return dishesGroups
        
    }
    
    func getDishesGroup(_ index: Int) -> DishesGroupModel {
        
        return dishesGroups[index]
        
    }
}
