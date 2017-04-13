//
//  ReservedTableModel.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 13.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//


import Foundation
import Firebase

class ReservedTableModel: FirebaseDataProtocol {
    
    //Properties
    
    var clientName: String = ""
    var commentClient: String = ""
    var date: [String:Int]
    var isCheckedByAdmin: Int
    var isNotificated: Int
    var key: String = ""
    var phoneClient: String
    var tableKey: String
    var userId: String
    
    //MARK: Init
    
    
    init(clientName: String, commentClient: String, date: [String:Int], isCheckedByAdmin: Int, isNotificated: Int, key: String, phoneClient: String, tableKey: String, userId: String) {
        self.clientName = clientName
        self.commentClient = commentClient
        self.date = date
        self.isCheckedByAdmin = isCheckedByAdmin
        self.isNotificated = isNotificated
        self.key = key
        self.phoneClient = phoneClient
        self.tableKey = tableKey
        self.userId = userId
    }
    
    //MARK: Functions
    
    func getPostData() -> [String : Any] {
        
        return [
            FirebaseTables.ReservedTables.Child.clientName : clientName,
            FirebaseTables.ReservedTables.Child.commentClient : commentClient,
            FirebaseTables.ReservedTables.Child.date : date,
            FirebaseTables.ReservedTables.Child.isCheckedByAdmin : isCheckedByAdmin,
            FirebaseTables.ReservedTables.Child.isNotificated : isNotificated,
            FirebaseTables.ReservedTables.Child.key : key,
            FirebaseTables.ReservedTables.Child.phoneClient : phoneClient,
            FirebaseTables.ReservedTables.Child.tableKey : tableKey,
            FirebaseTables.ReservedTables.Child.userId : userId,
            
        ]
        
    }
    
}

