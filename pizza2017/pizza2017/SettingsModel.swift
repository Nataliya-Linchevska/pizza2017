//
//  About.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

class SettingsModel {
       
    //MARK: Properties
    
    var address: String
    var email: String
    var latitude: Float
    var longitude: Float
    var phone: String
    var adminEmail: String
    
    //MARK: Init
    
    init(address: String, email: String, latitude: Float, longitude: Float, phone: String, adminEmail: String) {
        self.address = address
        self.email = email
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.adminEmail = adminEmail
    }
}
