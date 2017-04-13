//
//  AccountFirebaseHelper.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 11.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//


import Foundation
import Firebase

class AccountFirebaseHelper: FirebaseHelper {
    
    //MARK: Properties
    
    private var users = [UserModel]()
    
    //MARK: Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.Users.TableName
        
    }
    
    
    func initFirebaseObserve(userKey: String, callback: @escaping ()->()) {
        
        users.removeAll()
        
        super.initObserve { (snapshot) -> () in
            self.updateUsers(snapshot, userKey)
            callback()
        }
        
    }
    
    func getUsers() -> [UserModel] {
        
        return users
        
    }
    
    func getUser(_ index: Int) -> UserModel {
        
        return users[index]
        
    }
    
    private func updateUsers(_ snapshot: FIRDataSnapshot, _ dishKey: String) {
        
        users.removeAll()
        
        for items in snapshot.children {
            
            let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
            
            let name = tasksInFirebase[FirebaseTables.Users.Child.Name] as? String
            let address = tasksInFirebase[FirebaseTables.Users.Child.Address] as? String
            let email = tasksInFirebase[FirebaseTables.Users.Child.Email] as? String
            let phone = tasksInFirebase[FirebaseTables.Users.Child.Phone] as? String
            let keyGroup = tasksInFirebase[FirebaseTables.Users.Child.KeyGroup] as? String
            let key = tasksInFirebase[FirebaseTables.Users.Child.Key] as? String
           
            users.append(UserModel(name: name!, email: email!, address: address!, phone: phone!, key: key!))
            
            
            
        }
        
    }
}

