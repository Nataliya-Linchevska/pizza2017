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
    
    //MARK: Functions
        
    func reloadMenuGroups(callback: @escaping ()->()) {
        
        menuGroups.removeAll()
        
        reloadFirebaseData(childName: "menu_groups") { (snapshot) -> () in
            for items in snapshot.children {
                let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
                let key = tasksInFirebase["key"] as! String
                let name = tasksInFirebase["name"] as! String
                let photoName = tasksInFirebase["photoName"] as! String
                let photoUrl = tasksInFirebase["photoUrl"] as! String
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
