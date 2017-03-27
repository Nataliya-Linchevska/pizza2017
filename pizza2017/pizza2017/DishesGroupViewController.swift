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
    
    var firebaseHelper = DishesGroupFirebase()

    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseHelper.initFirebaseObserve(dishKey: keyForDish) { 
            self.collectionView.reloadData()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitFirebaseObserve()
    }
    
}

extension DishesGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firebaseHelper.getDishesGroups().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dishGroupCell", for: indexPath) as! DishesGroupCollectionViewCell
        
        let dishesGroup = firebaseHelper.getDishesGroup(indexPath.item)
        cell.lblTitle.text = dishesGroup.name
        cell.lblPrice.text = dishesGroup.price.description
        
        firebaseHelper.getImageFromStorage(nameOfImage: String(dishesGroup.photoName), callBack: { image in
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
