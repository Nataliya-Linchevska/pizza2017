//
//  UserModel.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 11.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class UserModel: FirebaseDataProtocol {
    
    //Properties
    
    var name: String = ""
    var email: String = ""
    var address: String = ""
    var phone: String = ""
    var keyGroup: String = ""
    var key: String = ""
    
    //MARK: Init
    
    init() { }
    
    init(name: String, email: String, address: String, phone: String, key: String) {
        self.name = name
        self.email = email
        self.address = address
        self.phone = phone
        self.key = key
    }
    
    //MARK: Functions
    
    func getPostData() -> [String : Any] {
        
        return [
            
            FirebaseTables.Users.Child.Key : key,
            FirebaseTables.Users.Child.KeyGroup : keyGroup,
            FirebaseTables.Users.Child.Name : name,
            FirebaseTables.Users.Child.Address : address,
            FirebaseTables.Users.Child.Phone : phone,
            FirebaseTables.Users.Child.Email : email,
            
        ]
        
    }
    
}

