//
//  Loger.swift
//  pizza2017
//
//  Created by konstantin on 3/29/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

class Loger {
    
    //MARK: Init singleton
    
    static let instance = Loger()
    
    private init() {}
    
    func writeToLog(_ message: String) {
        
        print(message)
    }
    
}
