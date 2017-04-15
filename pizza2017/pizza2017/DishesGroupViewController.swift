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
    
    var keyForDish: String?
    var firebaseHelper = DishFirebase()
    
    var editableDelegate: EditableViewProtocol?
        
    //MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if keyForDish == nil {
            Utilities.showAllertMessage("Error", "Menu groups key can't be empty!", self)
            closeView()
            return
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if UserHelper.instance.isAdminLogged {
            let barButton = UIBarButtonItem(image: Utilities.getDefaultMenuImage(),
                                            landscapeImagePhone: nil, style: .done,
                                            target: self, action: #selector(menuButtonClicked))
            self.navigationItem.rightBarButtonItem = barButton
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //activityIndicator.startAnimating()
        firebaseHelper.initDishesObserve(keyForDish!) {
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
        
        let menu = UIAlertController(title: nil, message: "Choose option", preferredStyle: .actionSheet)
        menu.addAction(UIAlertAction(title: "Add new dish", style: .default, handler: { (action:  UIAlertAction!) in
            self.onAddNewDish()
            menu.dismiss(animated: true, completion: nil)
        }))
        menu.addAction(UIAlertAction(title: "Edit group", style: .default, handler: { (action:  UIAlertAction!) in
            self.onEditGroup()
            menu.dismiss(animated: true, completion: nil)
        }))
        menu.addAction(UIAlertAction(title: "Remove group", style: .default, handler: { (action:  UIAlertAction!) in
            self.onRemoveGroup()
            menu.dismiss(animated: true, completion: nil)
        }))
        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action:  UIAlertAction!) in
            menu.dismiss(animated: true, completion: nil)
        }))
        
        present(menu, animated: true, completion: nil)
    }
    
    func onAddNewDish() {
        
        showDishEditView(nil)
        
    }
    
    func onEditGroup() {
        
        if let validDelegate = editableDelegate {
            validDelegate.onEditData?(keyForDish!, self)
        }
    }
    
    func onRemoveGroup() {
        
        if let validDelegate = self.editableDelegate {
            validDelegate.onDeleteData?(self.keyForDish!, self)
        }
    }
    
    func showDishEditView(_ dish: DishModel?) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "DishEditViewController") as! DishEditViewController
        controller.setModel(keyForDish!, dish)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func closeView() {
        
        if self.navigationController?.popViewController(animated: true) == nil {
            Loger.instance.writeToLog("View controller not found!")
        }
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
        
        if cell.ivImage.image == nil {
            firebaseHelper.getImageFromStorage(nameOfImage: dishesGroup.photoName, callBack: { image in
                cell.ivImage.image = image
            })
        }
        
        
        cell.ivImage.layer.cornerRadius = 10
        cell.ivImage.clipsToBounds = true
        cell.backgroundViewCell.layer.cornerRadius = 10
        
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
