//
//  DishesGroupModel.swift
//  pizza2017
//
//  Created by user on 02.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

class DishesGroupModel {
    
    //Properties
    
    var name: String = ""
    var description: String = ""
    var price: Float = 0
    var photoUrl: String = ""
    var photoName: String = ""
    var keyGroup: String = ""
    var key: String = ""
    
    //MARK: Init
    
    init() { }
    
    init(name: String, description: String, price: Float, photoUrl: String, photoName: String, keyGroup: String, key: String) {
        self.name = name
        self.description = description
        self.price = price
        self.photoUrl = photoUrl
        self.photoName = photoName
        self.keyGroup = keyGroup
        self.key = key
    }
}
