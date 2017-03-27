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
    
    //MARK: Properties
    
    private var dishesGroups = [DishesGroupModel]()
    
    //MARK: Firebase fields
    
    struct FirebaseFields {
        
        static let KeyGroup = "keyGroup"
        static let Name = "name"
        static let Description = "description"
        static let Price = "price"
        static let PhotoUrl = "photoUrl"
        static let PhotoName = "photoName"
        static let Key = "key"
        
    }
    
    //MARK: Functions
    
    override func getChildName() -> String {
        
        return FirebaseHelper.FirebaseChild.Dishes
        
    }
    
    func reloadDishesGroup(dishKey: String, callback: @escaping ()->()) {
        
        dishesGroups.removeAll()
        
        reloadFirebaseData { (snapshot) -> () in
            self.updateDishesGroups(snapshot, dishKey)
            callback()            
        }
        
    }
    
    func initFirebaseObserve(dishKey: String, callback: @escaping ()->()) {
        
        dishesGroups.removeAll()
        
        super.initFirebaseObserve { (snapshot) -> () in
            self.updateDishesGroups(snapshot, dishKey)
            callback()
        }
        
    }
    
    func getDishesGroups() -> [DishesGroupModel] {
        
        return dishesGroups
        
    }
    
    func getDishesGroup(_ index: Int) -> DishesGroupModel {
        
        return dishesGroups[index]
        
    }
    
    private func updateDishesGroups(_ snapshot: FIRDataSnapshot, _ dishKey: String) {
        
        dishesGroups.removeAll()
        
        for items in snapshot.children {
            
            let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
            let keyGroup = tasksInFirebase[FirebaseFields.KeyGroup] as! String
            if keyGroup != dishKey {
                continue
            }
            
            let name = tasksInFirebase[FirebaseFields.Name] as! String
            let description = tasksInFirebase[FirebaseFields.Description] as! String
            let price = tasksInFirebase[FirebaseFields.Price] as! Float
            let photoUrl = tasksInFirebase[FirebaseFields.PhotoUrl] as! String
            let photoName = tasksInFirebase[FirebaseFields.PhotoName] as! String
            let key = tasksInFirebase[FirebaseFields.Key] as! String
            
            dishesGroups.append(DishesGroupModel(name: name, description: description,
                                           price: price, photoUrl: photoUrl,
                                           photoName: photoName, keyGroup: keyGroup, key: key))
        }
        
    }
}
