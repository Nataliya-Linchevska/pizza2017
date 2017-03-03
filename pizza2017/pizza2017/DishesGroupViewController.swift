//
//  DishesGroupViewController.swift
//  pizza2017
//
//  Created by user on 02.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class DishesGroupViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var keyForDish: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        DishesGroupFirebase.keyForDish = keyForDish
        
        DishesGroupFirebase.getTasksFromFirebase {
            self.collectionView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
