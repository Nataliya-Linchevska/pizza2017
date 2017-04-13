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
    
    func removeGroupByKey(_ groupKey: String, _ callBack: ((Error?) -> Swift.Void)? = nil) {
        
        if let menuGroup = getMenuGroupByKey(groupKey) {
            
            removeImageFromStorage(imageName: menuGroup.photoName, callback: { (error) in
                if error == nil {
                    self.removeObjectByKey(menuGroup.key, { (error) in
                        if error == nil {
                            DishFirebase().removeDishesByGroupKey(menuGroup.key, callBack)
                        }
                    })
                } else if callBack != nil {
                    callBack!(error)
                }
            })
        }
        
    }
    
    //MARK: MenuGroups Functions
    
    func getMenuGroups() -> [MenuGroupsModel] {
        
        return menuGroups
        
    }
    
    func getMenuGroup(_ index: Int) -> MenuGroupsModel {
        
        return menuGroups[index]
        
    }
    
    func getMenuGroupByKey(_ groupKey: String) -> MenuGroupsModel? {
        
        return menuGroups.first(where: { $0.key == groupKey })
        
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
