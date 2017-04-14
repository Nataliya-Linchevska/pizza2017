//
//  EditableViewProtocol.swift
//  pizza2017
//
//  Created by konstantin on 4/4/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import UIKit

@objc protocol EditableViewProtocol {
    
    @objc optional func onEditData(_ itemIndex: Int)
    
    @objc optional func onDeleteData(_ itemIndex: Int)
    
    @objc optional func onEditData(_ key: String, _ viewController: UIViewController?)
   
    @objc optional func onDeleteData(_ key: String, _ viewController: UIViewController?)
    
}
