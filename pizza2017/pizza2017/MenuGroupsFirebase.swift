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
    
    //MARK: Init singleton
    
    static var instance = MenuGroupsFirebase()
    
    private override init(){}
    
    
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
        
    func reloadMenuGroups(callback: @escaping ()->()) {
        
        menuGroups.removeAll()
        
        reloadFirebaseData(childName: FirebaseHelper.FirebaseChild.MenuGroups) { (snapshot) -> () in
            for items in snapshot.children {
                let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
                let key = tasksInFirebase[FirebaseFields.Key] as! String
                let name = tasksInFirebase[FirebaseFields.Name] as! String
                let photoName = tasksInFirebase[FirebaseFields.PhotoName] as! String
                let photoUrl = tasksInFirebase[FirebaseFields.PhotoUrl] as! String
                self.menuGroups.append(MenuGroupsModel(key: key, name: name, photoName: photoName, photoUrl: photoUrl))
            }
            callback()
        }
        
    }
    
    func getMenuGroups() -> [MenuGroupsModel] {
        
        return menuGroups
        
    }
    
    func getMenuGroup(_ index: Int) -> MenuGroupsModel {
        
        return menuGroups[index]
        
    }
}
