//
//  DeliveryModel.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 05.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//


import Foundation

class DeliveryModel: FirebaseDataProtocol {
    
    //MARK: Properties
    
    var key: String = ""
    var name: String = ""
    var keyGroup: String = ""
    var addressClient: String = ""
    var commentClient: String = ""
    var keysDishes: [String] = []
    var latitude: String = ""
    var longitude: String = ""
    var nameClient: String = ""
    var numbersDishes: [String] = []
    var paid: String = ""
    var phoneClient: String = ""
    var totalSum: String = ""
    var userEmail: String = ""
    var userId: String = ""
    
    
    //MARK: Init
    
    init() {}
    
    convenience init(name: String, addressClient: String, commentClient: String, keysDishes: [String], latitude: String, longitude: String, nameClient: String, numbersDishes: [String], paid: String, phoneClient: String, totalSum: String, userEmail: String, userId: String) {
        self.init()
        self.name = name
        self.addressClient = addressClient
        self.commentClient = commentClient
        self.keysDishes = keysDishes
        self.latitude = latitude
        self.longitude = longitude
        self.nameClient = nameClient
        self.numbersDishes = numbersDishes
        self.paid = paid
        self.phoneClient = phoneClient
        self.totalSum = totalSum
        self.userEmail = userEmail
        self.userId = userId
        
    }
    
    
    
    //MARK: Functions
    
    func getPostData() -> [String : Any] {
        
        return [
            
            FirebaseTables.Deliveries.Child.Key : key,
            FirebaseTables.Deliveries.Child.Name : name,
            FirebaseTables.Deliveries.Child.KeyGroup : keyGroup,
            FirebaseTables.Deliveries.Child.AddressClient : addressClient,
            FirebaseTables.Deliveries.Child.CommentClient : commentClient,
            FirebaseTables.Deliveries.Child.KeysDishes : keysDishes,
            FirebaseTables.Deliveries.Child.Latitude : latitude,
            FirebaseTables.Deliveries.Child.Longitude : longitude,
            FirebaseTables.Deliveries.Child.NameClient : nameClient,
            FirebaseTables.Deliveries.Child.NumbersDishes : numbersDishes,
            FirebaseTables.Deliveries.Child.Paid : paid,
            FirebaseTables.Deliveries.Child.PhoneClient : phoneClient,
            FirebaseTables.Deliveries.Child.TotalSum : totalSum,
            FirebaseTables.Deliveries.Child.UserEmail : userEmail,
            FirebaseTables.Deliveries.Child.UserId : userId,
            
            
        ]
        
    }
    
}
