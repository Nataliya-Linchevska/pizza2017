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
    
    var keyForDish: String = ""
    
    var firebaseHelper = DishFirebase()
    
    //MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let barButton = UIBarButtonItem(image: Utilities.getDefaultMenuImage(),
                                        landscapeImagePhone: nil, style: .done,
                                        target: self, action: #selector(menuButtonClicked))
        self.navigationItem.rightBarButtonItem = barButton
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
    
    //MARK: Functions
    
    func menuButtonClicked() {
        
        let alert = UIAlertController(title: nil, message: "Choose option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit group", style: .default, handler: { (action:  UIAlertAction!) in
            self.onEditGroup()
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Add new dish", style: .default, handler: { (action:  UIAlertAction!) in
            self.onAddNewDish()
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Remove group", style: .default, handler: { (action:  UIAlertAction!) in
            self.onRemoveGroup()
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action:  UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func onAddNewDish() {
        
    }
    
    func onEditGroup() {
        
        /*let group = firebaseHelper.getMenuGroup(itemIndex)
        showEditMenuGroupView(group)*/
        print("edit")
    }
    
    func onRemoveGroup() {
        
        /*Utilities.showQuestionMessage("", "Do you really want to remove this group?", self) {
            let group = firebaseHelper.getMenuGroup(itemIndex)
            self.firebaseHelper.removeGroupByKey(group.key)
        }*/
        print("remove")
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
