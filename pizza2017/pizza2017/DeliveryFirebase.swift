//
//  DeliveryFirebase.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 05.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Foundation
import Firebase

class DeliveryFirebase: FirebaseHelper {
    
    //MARK: Properties
    
    private var deliveries = [DeliveryModel]()
    
    //MARK: Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.Deliveries.TableName
        
    }
    
    
    func initFirebaseObserve(dishKey: String, callback: @escaping ()->()) {
        
        deliveries.removeAll()
        
        super.initObserve { (snapshot) -> () in
            self.updateDeliveries(snapshot, dishKey)
            callback()
        }
        
    }
    
    func getDeliveries() -> [DeliveryModel] {
        
        return deliveries
        
    }
    
    func getDeliverie(_ index: Int) -> DeliveryModel {
        
        return deliveries[index]
        
    }
    
    private func updateDeliveries(_ snapshot: FIRDataSnapshot, _ dishKey: String) {
        
        deliveries.removeAll()
        
        for items in snapshot.children {
            
            let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
//            let keyGroup = tasksInFirebase[FirebaseTables.Deliveries.Child.KeyGroup] as! String
//            if keyGroup != dishKey {
//                continue
//            }
            
            let name = tasksInFirebase[FirebaseTables.Deliveries.Child.Name] as? String
            let addressClient = tasksInFirebase[FirebaseTables.Deliveries.Child.AddressClient] as? String
            let commentClient = tasksInFirebase[FirebaseTables.Deliveries.Child.CommentClient] as? String
            let keysDishes = tasksInFirebase[FirebaseTables.Deliveries.Child.KeysDishes] as? [String]
            let latitude = tasksInFirebase[FirebaseTables.Deliveries.Child.Latitude] as? String
            let longitude = tasksInFirebase[FirebaseTables.Deliveries.Child.Longitude] as? String
            let nameClient = tasksInFirebase[FirebaseTables.Deliveries.Child.NameClient] as? String
            let numbersDishes = tasksInFirebase[FirebaseTables.Deliveries.Child.NumbersDishes] as? [String]
            let paid = tasksInFirebase[FirebaseTables.Deliveries.Child.Paid] as? String
            let phoneClient = tasksInFirebase[FirebaseTables.Deliveries.Child.PhoneClient] as? String
            let totalSum = tasksInFirebase[FirebaseTables.Deliveries.Child.TotalSum] as? String
            let userEmail = tasksInFirebase[FirebaseTables.Deliveries.Child.UserEmail] as? String
            let userId = tasksInFirebase[FirebaseTables.Deliveries.Child.UserId] as? String
            
            deliveries.append(DeliveryModel(name: name ?? "", addressClient: addressClient ?? "", commentClient: commentClient ?? "", keysDishes: keysDishes ?? [""], latitude: latitude ?? "", longitude: longitude ?? "", nameClient: nameClient ?? "", numbersDishes: numbersDishes ?? [""], paid: paid ?? "", phoneClient: phoneClient ?? "", totalSum: totalSum ?? "", userEmail: userEmail ?? "", userId: userId ?? ""))
        }
        
    }
}
