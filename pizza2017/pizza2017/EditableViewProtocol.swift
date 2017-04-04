//
//  EditableViewProtocol.swift
//  pizza2017
//
//  Created by konstantin on 4/4/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

protocol EditableViewProtocol {
    
    func onEditData(_ itemIndex: Int)
    
    func onDeleteData(_ itemIndex: Int)
    
}
