//
//  DishViewController.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class DishViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var firebaseHelper = DishesGroupFirebase()

    var keyForDish: String = ""
    //MARK: Virtual functions - ?????
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseHelper.initFirebaseObserve(dishKey: keyForDish) {
            self.collectionView.reloadData()
        }
        
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitObserve()
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firebaseHelper.getDishesGroups().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as! DishCollectionViewCell
        
        let dishesGroup = firebaseHelper.getDishesGroup(indexPath.item)
        cell.lblPrice.text = "\(dishesGroup.price)"
        cell.lblPrice.text = dishesGroup.price.description
        
        firebaseHelper.getImageFromStorage(nameOfImage: String(dishesGroup.photoName), callBack: { image in
            cell.ivImage.image = image
        })

        return cell
    }
    
    //MARK: Actions
    
    @IBAction func btnNext(_ sender: UIButton) {
    }
    
    @IBAction func btnPrevious(_ sender: UIButton) {
    }
    
    @IBAction func btnAddDishToList(_ sender: UIButton) {
    }
    
}
