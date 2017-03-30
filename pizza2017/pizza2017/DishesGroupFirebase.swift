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
    
    //MARK: Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.Dishes.TableName
        
    }
    
    override func getImageFolderName() -> String {
        
        return FirebaseTables.Dishes.ImageFolder
        
    }

    
    func reloadDishesGroup(dishKey: String, callback: @escaping ()->()) {
        
        dishesGroups.removeAll()
        
        reloadData { (snapshot) -> () in
            self.updateDishesGroups(snapshot, dishKey)
            callback()            
        }
        
    }
    
    func initFirebaseObserve(dishKey: String, callback: @escaping ()->()) {
        
        dishesGroups.removeAll()
        
        super.initObserve { (snapshot) -> () in
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
            let keyGroup = tasksInFirebase[FirebaseTables.Dishes.Child.KeyGroup] as! String
            if keyGroup != dishKey {
                continue
            }
            
            let name = tasksInFirebase[FirebaseTables.Dishes.Child.Name] as! String
            let description = tasksInFirebase[FirebaseTables.Dishes.Child.Description] as! String
            let price = tasksInFirebase[FirebaseTables.Dishes.Child.Price] as! Float
            let photoUrl = tasksInFirebase[FirebaseTables.Dishes.Child.PhotoUrl] as! String
            let photoName = tasksInFirebase[FirebaseTables.Dishes.Child.PhotoName] as! String
            let key = tasksInFirebase[FirebaseTables.Dishes.Child.Key] as! String
            
            dishesGroups.append(DishesGroupModel(name: name, description: description,
                                           price: price, photoUrl: photoUrl,
                                           photoName: photoName, keyGroup: keyGroup, key: key))
        }
        
    }
}
