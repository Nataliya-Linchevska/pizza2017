//
//  FirebaseDataProtocol.swift
//  pizza2017
//
//  Created by konstantin on 4/1/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

protocol FirebaseDataProtocol {
    
    var key: String { get set}
    
    func getPostData() -> [String : Any]
    
}
