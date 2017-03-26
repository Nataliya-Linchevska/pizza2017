//
//  MenuGroupsModel.swift
//  pizza2017
//
//  Created by user on 24.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

class MenuGroupsModel {
        
    //MARK: Properties
    
    var key: String = ""
    var name: String = ""
    var photoName: String = ""
    var photoUrl: String = ""
    
    //MERK: Init
    
    init() {}
    
    init(key: String, name: String, photoName: String, photoUrl: String) {
        self.key = key
        self.name = name
        self.photoName = photoName
        self.photoUrl = photoUrl
    }
}
