//
//  MenuGroupsCollectionViewCell.swift
//  pizza2017
//
//  Created by user on 28.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class MenuGroupsCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    var firebaseHelper = MenuGroupsFirebase()
    private var groupIndex = 0
    
    //MARK: Outlets
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: General Functions
    
    func fillUp(_ itemIndex: Int, _ groupName: String, _ photoName: String) {
        
//        activityIndicator.startAnimating()
        
        groupIndex = itemIndex
        lblTitle.text = groupName
        
    }
    
}
