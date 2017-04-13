//
//  DishesGroupFirebase.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class DishFirebase: FirebaseHelper {
    
    //MARK: Properties
    
    private var dishes = [DishModel]()
    
    //MARK: Firebase Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.Dishes.TableName
        
    }
    
    override func getImageFolderName() -> String {
        
        return FirebaseTables.Dishes.ImageFolder
        
    }
    
    func initDishesObserve(_ menuGroupKey: String, callback: @escaping ()->()) {
        
        dishes.removeAll()
        initObserveBySubKey(subKeyName: FirebaseTables.Dishes.Child.KeyGroup, subKeyValue: menuGroupKey) { (snapshot) in
            self.updateDishesGroups(snapshot, menuGroupKey)
            callback()
        }
        
    }
    
    func removeDishesByGroupKey(_ groupKey: String, _ callBack: ((Error?) -> Swift.Void)? = nil) {
        
        removeObjectBySubKey(subKeyName: FirebaseTables.Dishes.Child.KeyGroup, subKeyValue: groupKey, errorCallback: nil) { (snapshot) in
            
            let dishesForRemove = self.getDishesFromSnapshot(snapshot, groupKey)
            for dish in dishesForRemove {
                
                self.removeDish(dish, callBack)
                self.removeDish(dish, { (error) in
                    if error != nil && callBack != nil {
                        callBack!(error)
                        return
                    }
                })
            }
        }
    }
    
    func removeDish(_ dish: DishModel, _ callBack: ((Error?) -> Swift.Void)? = nil) {
        
        self.removeImageFromStorage(imageName: dish.photoName) { (error) in
            if error == nil {
                self.removeObjectByKey(dish.key, callBack)
            }
        }
    }
    
    //MARK: Dishes Functions
    
    func getDishes() -> [DishModel] {
        
        return dishes
        
    }
    
    func getDish(_ index: Int) -> DishModel {
        
        return dishes[index]
        
    }
    
    private func updateDishesGroups(_ snapshot: FIRDataSnapshot, _ dishKey: String) {
        
        dishes.removeAll()
        dishes.append(contentsOf: getDishesFromSnapshot(snapshot, dishKey))
    
    }
    
    private func getDishesFromSnapshot(_ snapshot: FIRDataSnapshot, _ dishKey: String) -> [DishModel] {
        
        var result = [DishModel]()
        
        for items in snapshot.children {
            
            let validDishDictionary = (items as! FIRDataSnapshot).value as! NSDictionary
            let keyGroup = validDishDictionary[FirebaseTables.Dishes.Child.KeyGroup] as! String
            let name = validDishDictionary[FirebaseTables.Dishes.Child.Name] as! String
            let description = validDishDictionary[FirebaseTables.Dishes.Child.Description] as! String
            let price = validDishDictionary[FirebaseTables.Dishes.Child.Price] as! Float
            let photoUrl = validDishDictionary[FirebaseTables.Dishes.Child.PhotoUrl] as! String
            let photoName = validDishDictionary[FirebaseTables.Dishes.Child.PhotoName] as! String
            let key = validDishDictionary[FirebaseTables.Dishes.Child.Key] as! String
            
            let dish = DishModel(name: name, description: description,
                                 price: price, photoUrl: photoUrl,
                                 photoName: photoName, keyGroup: keyGroup, key: key)
            
            result.append(dish)
        }
        
        return result
        
    }
    
}
