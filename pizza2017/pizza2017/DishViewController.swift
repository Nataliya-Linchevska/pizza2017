//
//  DishViewController.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class DishViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var tvDescription: UITextView!

    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    
    @IBAction func btnNext(_ sender: UIButton) {
    }
    
    @IBAction func btnPrevious(_ sender: UIButton) {
    }
    
    @IBAction func btnAddDishToList(_ sender: UIButton) {
    }
    
}
