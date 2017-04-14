//
//  MenuViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    //MARK: Properties
    
    var firebaseHelper = MenuGroupsFirebase()
    
    //MARK: Outlets
    
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.clearsContextBeforeDrawing = true
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        if !UserHelper.instance.isAdminLogged {
            topNavigationItem.rightBarButtonItem = nil
        }
        activityIndicator.startAnimating()
        firebaseHelper.initMenuGroupsObserve {
            self.CollectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitObserve()
    }
    
    //MARK: Actions
  
    @IBAction func addMenuGroupClick(_ sender: UIBarButtonItem) {
        
        showEditMenuGroupView(nil)
    }
    
    //MARK: Functions
    
    func showEditMenuGroupView(_ group: MenuGroupsModel?) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "MenuEditViewController") as! MenuEditViewController
        controller.setModel(group)
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firebaseHelper.getMenuGroups().count
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuGroupCell", for: indexPath) as! MenuGroupsCollectionViewCell
        
        let menuGroup = firebaseHelper.getMenuGroup(indexPath.item)
        cell.fillUp(indexPath.item, menuGroup.name, menuGroup.photoName)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DishesGroup") as! DishesGroupViewController
        // Передаю ключ їжі який відображати в наступному контроллері
        controller.keyForDish = firebaseHelper.getMenuGroup(indexPath.item).key
        controller.editableDelegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MenuViewController: EditableViewProtocol {
    
    func onEditData(_ key: String, _ viewController: UIViewController?) {
        
        guard let group = firebaseHelper.getMenuGroupByKey(key) else {
            return
        }
        showEditMenuGroupView(group)
        
    }
    
    func onDeleteData(_ key: String, _ viewController: UIViewController?) {
        
        guard let validViewController = viewController else {
            return
        }
        Utilities.showQuestionMessage("", "Do you really want to remove this group?", validViewController) {
            
            self.firebaseHelper.removeGroupByKey(key) { (error) in
                if let validError = error {
                    Utilities.showAllertMessage("Error", validError.localizedDescription, validViewController)
                } else {
                    
                    guard validViewController.navigationController?.popViewController(animated: true) != nil else {
                        Loger.instance.writeToLog("View controller not found!")
                        return
                    }
                    
                }
            }
        }
    }
    
}
