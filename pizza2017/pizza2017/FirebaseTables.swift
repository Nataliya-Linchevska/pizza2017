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
            
        }
    }
    
    //MARK: Tables
    
    struct Tables {
        
        static let TableName = "tables"
        
        struct Child {
            
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
            
        }
    }
}
