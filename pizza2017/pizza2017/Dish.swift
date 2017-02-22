//
//  Dish.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
class Dish {
    var name: String
    var description: String
    var price: Float
    var photoUrl: String
    var photoName: String
    var keyGroup: String
    var key: String
    
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
