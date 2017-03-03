//
//  DishesGroupViewController.swift
//  pizza2017
//
//  Created by user on 02.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class DishesGroupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var keyForDish: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        DishesGroupFirebase.keyForDish = keyForDish
        
        DishesGroupFirebase.getTasksFromFirebase {
            self.collectionView.reloadData()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DishesGroupFirebase.arrayOfDishesGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dishGroupCell", for: indexPath) as! DishesGroupCollectionViewCell
        
        cell.lblTitle.text = DishesGroupFirebase.arrayOfDishesGroups[indexPath.item].name
        cell.lblPrice.text = DishesGroupFirebase.arrayOfDishesGroups[indexPath.item].price.description
        
        MenuGroupsStorage.getImageFromStorage(nameOfImage: String(DishesGroupFirebase.arrayOfDishesGroups[indexPath.item].photoName) , callBack: { image in
            cell.ivImage.image = image
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "Dish") as! DishViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
