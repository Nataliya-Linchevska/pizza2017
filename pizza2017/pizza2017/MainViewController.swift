//
//  MainViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var shadowButtonView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowButtonView.layer.shadowOpacity = 0.8
        shadowButtonView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        shadowButtonView.layer.cornerRadius = 22



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
