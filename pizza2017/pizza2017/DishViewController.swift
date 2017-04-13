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
    @IBOutlet weak var btnRight: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var firebaseHelper = DishFirebase()

    var keyForDish: String?
    var selectedIndex: IndexPath?
    
    //MARK: Virtual functions - ?????
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if keyForDish == nil {
            Utilities.showAllertMessage("Error", "Menu groups key can't be empty!", self)
            dismiss(animated: false, completion: nil)
            return
        }
        
        if !UserHelper.instance.isAdminLogged {
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {    
        super.viewWillAppear(animated)
        
        firebaseHelper.initDishesObserve(keyForDish!, callback: {
            self.collectionView.reloadData()

            self.collectionView.scrollToItem(at: self.selectedIndex!, at: .left, animated: false)
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var sum = 0.0
        _ = BacketHelper.backetDishes.map({ (m) in
            sum += Double(m.price)
        })
        
        btnRight.title = "Козина(\(sum))"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitObserve()
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firebaseHelper.getDishes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as! DishCollectionViewCell
        
        let dishesGroup = firebaseHelper.getDish(indexPath.item)
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
        if selectedIndex.row>=firebaseHelper.getDishes().count {return}
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
        
        guard var selectedIndex = collectionView.indexPath(for:
            collectionView.visibleCells.first!) else {
                return
        }
        let dishesGroup = firebaseHelper.getDish(selectedIndex.row)
        let dish = DishModel(name: dishesGroup.name, description: dishesGroup.description, price: dishesGroup.price, photoUrl: dishesGroup.photoUrl, photoName: dishesGroup.photoName, keyGroup: dishesGroup.keyGroup, key: dishesGroup.key)
        
        BacketHelper.backetDishes.append(dish)
        
        var sum = 0.0
        _ = BacketHelper.backetDishes.map({ (m) in
            sum += Double(m.price)
        })
        
        btnRight.title = "Козина(\(sum))"
        
        let alert = UIAlertController(title: "", message: "Блюдо добавлено в корзину", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
