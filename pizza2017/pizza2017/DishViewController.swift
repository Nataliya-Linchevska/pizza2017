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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {    
        super.viewWillAppear(animated)
        
        //activityIndicator.startAnimating()
        firebaseHelper.initDishesObserve(keyForDish, callback: {
            self.collectionView.reloadData()
            //self.activityIndicator.stopAnimating()
        })
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as! DishCollectionViewCell
        
        let dishesGroup = firebaseHelper.getDishesGroup(indexPath.item)
        cell.lblPrice.text = "\(dishesGroup.price)"
        cell.tvDescription.text = dishesGroup.description
        cell.lblTitle.text = dishesGroup.name
        
        firebaseHelper.getImageFromStorage(nameOfImage: String(dishesGroup.photoName), callBack: { image in
            cell.ivImage.image = image
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) { 
            cell.alpha = 1.0
        }
    }
    
    //MARK: Actions
    @IBAction func btnNext(_ sender: UIButton) {
        guard var selectedIndex = collectionView.indexPath(for:
             collectionView.visibleCells.first!) else {
            return
        }
        
        selectedIndex.row += 1
        if selectedIndex.row>=firebaseHelper.getDishesGroups().count {return}
        collectionView.scrollToItem(at: selectedIndex, at: .left, animated: true)
    }
    
    @IBAction func btnPrevious(_ sender: UIButton) {
        guard var selectedIndex = collectionView.indexPath(for:
            collectionView.visibleCells.first!) else {
                return
        }
        
        selectedIndex.row -= 1
        if selectedIndex.row < 0{return}
        collectionView.scrollToItem(at: selectedIndex, at: .left, animated: true)

    }
    
    @IBAction func btnAddDishToList(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "", message: "Блюдо добавлено в корзину", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
