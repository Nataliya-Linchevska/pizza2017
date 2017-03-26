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
    
    //MARK: Firebase field names
    
    struct FirebaseFields {
        
        static let Key = "key"
        static let Name = "name"
        static let PhotoName = "photoName"
        static let PhotoUrl = "photoUrl"
        
    }
    
    //MARK: Functions
    
    override func getChildName() -> String {
        
        return FirebaseHelper.FirebaseChild.MenuGroups
        
    }
        
    func reloadMenuGroups(callback: @escaping ()->()) {
        
        menuGroups.removeAll()
        
        reloadFirebaseData{ (snapshot) -> () in            
            self.menuGroups.append(contentsOf: self.getMenuGroups(snapshot))
            callback()
        }
        
    }
    
    func initFirebaseObserve(callback: @escaping ()->()) {
        
        menuGroups.removeAll()
        
        super.initFirebaseObserve { (snapshot) -> () in
            self.menuGroups.append(contentsOf: self.getMenuGroups(snapshot))
            callback()
        }

    }
    
    func getMenuGroups() -> [MenuGroupsModel] {
        
        return menuGroups
        
    }
    
    func getMenuGroup(_ index: Int) -> MenuGroupsModel {
        
        return menuGroups[index]
        
    }
    
    private func getMenuGroups(_ snapshot: FIRDataSnapshot) -> [MenuGroupsModel] {
        
        var result = [MenuGroupsModel]()
        
        for items in snapshot.children {
            let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
            let key = tasksInFirebase[FirebaseFields.Key] as! String
            let name = tasksInFirebase[FirebaseFields.Name] as! String
            let photoName = tasksInFirebase[FirebaseFields.PhotoName] as! String
            let photoUrl = tasksInFirebase[FirebaseFields.PhotoUrl] as! String
            result.append(MenuGroupsModel(key: key, name: name, photoName: photoName, photoUrl: photoUrl))
        }
        
        return result
        
    }
}
