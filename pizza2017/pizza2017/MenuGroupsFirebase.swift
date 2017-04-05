//
//  MenuGroupsFirebase.swift
//  pizza2017
//
//  Created by user on 24.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class MenuGroupsFirebase: FirebaseHelper {
    
    //MARK: Properties
    
    private var menuGroups = [MenuGroupsModel]()
    
    //MARK: Firebase Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.MenuGroups.TableName
        
    }
    
    override func getImageFolderName() -> String {
        
        return FirebaseTables.MenuGroups.ImageFolder
        
    }
    
    func initMenuGroupsObserve(callback: @escaping ()->()) {
        
        menuGroups.removeAll()
        
        super.initObserve { (snapshot) -> () in
            self.updateMenuGroups(snapshot)
            callback()
        }

    }
    
    func removeGroupByKey(_ groupKey: String) {
        
        removeObjectByKey(groupKey)
        DishesGroupFirebase().removeDishesByGroupKey(groupKey)
    }
    
    //MARK: Firebase Functions
    
    func getMenuGroups() -> [MenuGroupsModel] {
        
        return menuGroups
        
    }
    
    func getMenuGroup(_ index: Int) -> MenuGroupsModel {
        
        return menuGroups[index]
        
    }
    
    private func updateMenuGroups(_ snapshot: FIRDataSnapshot) {
        
        menuGroups.removeAll()
        
        for items in snapshot.children {
            let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
            let key = tasksInFirebase[FirebaseTables.MenuGroups.Child.Key] as! String
            let name = tasksInFirebase[FirebaseTables.MenuGroups.Child.Name] as! String
            let photoName = tasksInFirebase[FirebaseTables.MenuGroups.Child.PhotoName] as! String
            let photoUrl = tasksInFirebase[FirebaseTables.MenuGroups.Child.PhotoUrl] as! String
            menuGroups.append(MenuGroupsModel(key: key, name: name, photoName: photoName, photoUrl: photoUrl))
        }
        
    }
}
