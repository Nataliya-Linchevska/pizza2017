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
    
    //MARK: Outlets
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewAdminSettings: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: General Functions
    
    func fillUp(_ groupName: String, _ photoName: String, _ isAdminLogged: Bool) {
        
        activityIndicator.startAnimating()
        
        lblTitle.text = groupName
        
        firebaseHelper.getImageFromStorage(nameOfImage: photoName, callBack: { image in
            self.ivImage.image = image
            self.activityIndicator.stopAnimating()
        })
        
        if viewAdminSettings != nil && !isAdminLogged {
            viewAdminSettings.removeFromSuperview()
        }
        
    }
    
    
    //MARK: Actions
    
    @IBAction func buttonRemovePressed(_ sender: UIButton) {
        
        print("Removed")
        
    }
    
    
    @IBAction func buttonEditPressed(_ sender: UIButton) {
        
        print("Edit")
        
    }
    
    
    
}
