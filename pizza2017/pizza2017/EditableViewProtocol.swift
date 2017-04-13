//
//  EditableViewProtocol.swift
//  pizza2017
//
//  Created by konstantin on 4/4/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

@objc protocol EditableViewProtocol {
    
    @objc optional func onEditData(_ itemIndex: Int)
    
    @objc optional func onDeleteData(_ itemIndex: Int)
    
    @objc optional func onEditData(_ key: String, completion: ((Error?) -> Swift.Void)?)
   
    @objc optional func onDeleteData(_ key: String, completion: ((Error?) -> Swift.Void)?)
    
}
