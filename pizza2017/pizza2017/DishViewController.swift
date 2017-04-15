//
//  DishViewController.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class DishViewController: UIViewController {
    
    //MARK: Properties
    var firebaseHelper = DishFirebase()
    var keyForDish: String?
    var selectedIndex: IndexPath?
    
    @IBOutlet weak var btnAdd: UIButton!
    //MARK: Outlets
    
    @IBOutlet weak var btnRight: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if keyForDish == nil {
            Utilities.showAllertMessage("Error", "Menu groups key can't be empty!", self)
            closeView()
            return
        }
        
        if UserHelper.instance.isAdminLogged {
            
            let barButton = UIBarButtonItem(image: Utilities.getDefaultMenuImage(),
                                            landscapeImagePhone: nil, style: .done,
                                            target: self, action: #selector(menuButtonClicked))
            self.navigationItem.rightBarButtonItem = barButton
            btnAdd.isEnabled = false
        }
        
        if UserHelper.instance.userModel == nil {
            self.navigationItem.rightBarButtonItem = nil
            btnAdd.isEnabled = false
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = backgroundView.bounds
        gradient.colors = [UIColor(colorLiteralRed: 21/255.0, green: 136/255.0, blue: 18/255.0, alpha: 1).cgColor, UIColor(colorLiteralRed: 254/255.0, green: 244/255.0, blue: 85/255.0, alpha: 1).cgColor]
        backgroundView.layer.addSublayer(gradient)
        
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
       
        setBasketTitle(sum)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitObserve()
    }
    
    //MARK: Functions
    
    func setBasketTitle(_ sum: Double) {
        
        if btnRight != nil {
            btnRight.title = "Корзина(\(sum))"
        }
    }
    
    private func closeView() {
        
        if self.navigationController?.popViewController(animated: true) == nil {
            Loger.instance.writeToLog("View controller not found!")
        }
    }
    
    func menuButtonClicked() {
        
        let menu = UIAlertController(title: nil, message: "Choose option", preferredStyle: .actionSheet)
        menu.addAction(UIAlertAction(title: "Add new dish", style: .default, handler: { (action:  UIAlertAction!) in
            self.onAddNewDish()
            menu.dismiss(animated: true, completion: nil)
        }))
        menu.addAction(UIAlertAction(title: "Edit dish", style: .default, handler: { (action:  UIAlertAction!) in
            self.onEditDish()
            menu.dismiss(animated: true, completion: nil)
        }))
        menu.addAction(UIAlertAction(title: "Remove dish", style: .default, handler: { (action:  UIAlertAction!) in
            self.onRemoveDish()
            menu.dismiss(animated: true, completion: nil)
        }))
        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action:  UIAlertAction!) in
            menu.dismiss(animated: true, completion: nil)
        }))
        
        present(menu, animated: true, completion: nil)

    }
    
    private func onAddNewDish() {
        
        showDishEditView(nil)
        
    }
    
    func onEditDish() {
        
        guard let validIndex = selectedIndex else {
            Utilities.showAllertMessage("Error", "Can't start editing. Invalid dish index!", self)
            return
        }
        showDishEditView(firebaseHelper.getDish(validIndex.row))
    }
    
    func onRemoveDish() {
        
        guard let validIndex = selectedIndex else {
            Utilities.showAllertMessage("Error", "Can't delete dish. Invalid dish index!", self)
            return
        }
        firebaseHelper.removeDish(firebaseHelper.getDish(validIndex.row)) { (error) in
            guard let validError = error else {
                if self.firebaseHelper.getDishes().count == 0 {
                    self.closeView()
                }
                return
            }
            Utilities.showAllertMessage("Error", validError.localizedDescription, self)
        }
    }
    
    func showDishEditView(_ dish: DishModel?) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "DishEditViewController") as! DishEditViewController
        controller.setModel(keyForDish!, dish)
        navigationController?.pushViewController(controller, animated: true)
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
        
        setBasketTitle(sum)
        
        let alert = UIAlertController(title: "", message: "Блюдо добавлено в корзину", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DishViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    
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
        
        if cell.ivImage.image == nil {
            firebaseHelper.getImageFromStorage(nameOfImage: String(dishesGroup.photoName), callBack: { image in
                cell.ivImage.image = image
            })
        }
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1.0
        }
    }
    
}
