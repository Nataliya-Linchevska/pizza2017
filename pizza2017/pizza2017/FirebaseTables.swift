//
//  FirebaseTables.swift
//  pizza2017
//
//  Created by konstantin on 3/30/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

struct FirebaseTables {
    
    //MARK: Courier
        
    struct Courier {
        
        static let TableName = "courier"
        
        struct Child {
            
        }
    }
    
    //MARK: Deliveries
    
    struct Deliveries {
        
        static let TableName = "deliveries"
        
        struct Child {
            static let KeyGroup = "keyGroup"
            static let Name = "name"
            static let AddressClient = "addressClient"
            static let Key = "key"
            static let CommentClient = "commentClient"
            static let KeysDishes = "keysDishes"
            static let Latitude = "latitude"
            static let Longitude = "longitude"
            static let NameClient = "nameClient"
            static let NumbersDishes = "numbersDishes"
            static let Paid = "paid"
            static let PhoneClient = "phoneClient"
            static let TotalSum = "totalSum"
            static let UserEmail = "userEmail"
            static let UserId = "userId"
            
        }
    }
    
    //MARK: Dishes
    
    struct Dishes {
        
        static let TableName = "dishes"
        static let ImageFolder = "dishes_images"
        
        struct Child {
            
            static let KeyGroup = "keyGroup"
            static let Name = "name"
            static let Description = "description"
            static let Price = "price"
            static let PhotoUrl = "photoUrl"
            static let PhotoName = "photoName"
            static let Key = "key"
            
        }
    }
    
    //MARK: MenuGroups
    
    struct MenuGroups {
        
        static let TableName = "menu_groups"
        static let ImageFolder = "menu_group_images"
        
        struct Child {
            
            static let Key = "key"
            static let Name = "name"
            static let PhotoName = "photoName"
            static let PhotoUrl = "photoUrl"
            
        }

    }
    
    //MARK: News
    
    struct News {
        
        static let TableName = "news"
        static let ImageFolder = "news_images"
        
        struct Child {
            
        }
        
    }
    
    //MARK: Settings
    
    struct Settings {
        
        static let TableName = "settings"
        
        struct Child {
            
            static let Adress = "address"
            static let Email = "email"
            static let Latitude = "latitude"
            static let Longitude = "longitude"
            static let Phone = "phone"
            
        }
        
    }
    
    //MARK: ReservedTables
    
    struct ReservedTables {
        
        static let TableName = "reserved_tables"
        
        struct Child {
            static let clientName = "clientName"
            static let commentClient = "commentClient"
            static let date = "date"
            static let isCheckedByAdmin = "isCheckedByAdmin"
            static let isNotificated = "isNotificated"
            static let key = "key"
            static let phoneClient = "phoneClient"
            static let tableKey = "tableKey"
            static let userId = "userId"
        }
    }
    
    //MARK: Tables
    
    struct Tables {
        
        static let TableName = "tables"
        
        struct Child {
            static let pictureId = "pictureId"
            static let pictureName = "pictureName"
            static let portraitMode = "portraitMode"
            static let rotation = "rotation"
            static let tableId = "tableId"
            static let key = "key"
            static let xCoordinate = "xCoordinate"
            static let xResolution = "xResolution"
            static let yCoordinate = "yCoordinate"
            static let yResolution = "yResolution"
            
        }
    }
    
    //MARK: Topics
    
    struct Topics {
        
        static let TableName = "topics"
        
        struct Child {
            
        }
    }
    
    //MARK: Users
    
    struct Users {
        
        static let TableName = "users"
        
        struct Child {
            
            static let Name = "name"
            static let Email = "email"
            static let Address = "address"
            static let Phone = "phone"
            static let KeyGroup = "keyGroup"
            static let Key = "key"
            
        }
    }
}
