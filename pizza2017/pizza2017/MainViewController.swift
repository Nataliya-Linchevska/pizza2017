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
    @IBOutlet weak var shadowReserveView: UIView!
    @IBOutlet weak var shadowNewsView: UIView!
    @IBOutlet weak var shadowAboutView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 65/255.0, green: 129/255.0, blue: 37/255.0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black

        
        shadowButtonView.layer.shadowOpacity = 0.8
        shadowButtonView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        shadowButtonView.layer.cornerRadius = 22
        
        shadowReserveView.layer.shadowOpacity = 0.8
        shadowReserveView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        shadowReserveView.layer.cornerRadius = 22
        
        shadowNewsView.layer.shadowOpacity = 0.8
        shadowNewsView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        shadowNewsView.layer.cornerRadius = 22
        
        shadowAboutView.layer.shadowOpacity = 0.8
        shadowAboutView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        shadowAboutView.layer.cornerRadius = 22
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
