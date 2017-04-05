//
//  BacketTableViewCell.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 05.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class BacketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgDishImage: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblPrice: UILabel?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
