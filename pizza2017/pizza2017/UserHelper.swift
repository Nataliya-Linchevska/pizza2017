//
//  LoginHelper.swift
//  pizza2017
//
//  Created by konstantin on 3/21/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class UserHelper {
    
    //MARK: Init singleton
    
    static let instance = UserHelper()
    
    var userModel: UserModel?
    
    private init() {
    }
    
    //MARK: Properties
    
    var isAdminLogged = true
    
}
