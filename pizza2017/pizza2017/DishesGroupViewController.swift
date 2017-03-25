//
//  DishesGroupViewController.swift
//  pizza2017
//
//  Created by user on 02.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class DishesGroupViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var keyForDish: String = ""

    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DishesGroupFirebase.instance.reloadDishesGroup(dishKey: keyForDish, callback: { 
            self.collectionView.reloadData()
        })
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension DishesGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DishesGroupFirebase.instance.getDishesGroups().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dishGroupCell", for: indexPath) as! DishesGroupCollectionViewCell
        
        let dishesGroup = DishesGroupFirebase.instance.getDishesGroup(indexPath.item)
        cell.lblTitle.text = dishesGroup.name
        cell.lblPrice.text = dishesGroup.price.description
        
        DishesGroupFirebase.instance.getImageFromStorage(nameOfImage: String(dishesGroup.photoName), callBack: { image in
            cell.ivImage.image = image
        })
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "Dish") as! DishViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }

    
}
