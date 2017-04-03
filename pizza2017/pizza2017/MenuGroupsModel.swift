//
//  MenuGroupsModel.swift
//  pizza2017
//
//  Created by user on 24.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

class MenuGroupsModel: FirebaseDataProtocol {
        
    //MARK: Properties
    
    var key: String = ""
    var name: String = ""
    var photoName: String = ""
    var photoUrl: String = ""
    
    //MARK: Init
    
    init() {}
    
    init(key: String, name: String, photoName: String, photoUrl: String) {
        self.key = key
        self.name = name
        self.photoName = photoName
        self.photoUrl = photoUrl
    }
    
    //MARK: Functions
    
    func getPostData() -> [String : Any] {
        
        return [
            
            FirebaseTables.MenuGroups.Child.Key : key,
            FirebaseTables.MenuGroups.Child.Name : name,
            FirebaseTables.MenuGroups.Child.PhotoName : photoName,
            FirebaseTables.MenuGroups.Child.PhotoUrl : photoUrl,
        
        ]
        
    }
    
}
