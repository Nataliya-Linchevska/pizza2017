//
//  About.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

class SettingsModel {
    var address: String
    var email: String
    var latitude: Float
    var longitude: Float
    var phone: String
    
    init(address: String, email: String, latitude: Float, longitude: Float, phone: String) {
        self.address = address
        self.email = email
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
    }
}
