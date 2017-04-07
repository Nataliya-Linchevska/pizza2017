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
    
    var firebaseHelper = DishFirebase()

    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //activityIndicator.startAnimating()
        firebaseHelper.initDishesObserve(keyForDish) { 
            self.collectionView.reloadData()
            //self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitObserve()
    }
    
}

extension DishesGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firebaseHelper.getDishes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dishGroupCell", for: indexPath) as! DishesGroupCollectionViewCell
        
        let dishesGroup = firebaseHelper.getDish(indexPath.item)
        cell.lblTitle.text = dishesGroup.name
        cell.lblPrice.text = dishesGroup.price.description
        
        firebaseHelper.getImageFromStorage(nameOfImage: dishesGroup.photoName, callBack: { image in
            cell.ivImage.image = image
        })
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "Dish") as! DishViewController
        controller.keyForDish = keyForDish
        controller.selectedIndex = indexPath

        navigationController?.pushViewController(controller, animated: true)
    }

    
}
