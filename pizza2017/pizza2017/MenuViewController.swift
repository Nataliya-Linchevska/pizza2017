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
    
    @IBOutlet weak var activityIndicatorView: UIView!
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.clearsContextBeforeDrawing = true
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        if !UserHelper.instance.isAdminLogged {
            topNavigationItem.rightBarButtonItem = nil
        }        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // self.CollectionView.cl
        activityIndicatorView.isHidden = false
        activityIndicator.startAnimating()
        firebaseHelper.initMenuGroupsObserve {            
            self.CollectionView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicatorView.isHidden = true
        }
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
        self.present(controller, animated: true)
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
    
    func onEditData(_ key: String, completion: ((Error?) -> Void)?) {
        
        guard let group = firebaseHelper.getMenuGroupByKey(key) else {
            return
        }
        showEditMenuGroupView(group)
        
    }
    
    func onDeleteData(_ key: String, completion: ((Error?) -> Void)?) {
        
        firebaseHelper.removeGroupByKey(key) { (error) in
            if completion != nil {
                completion!(error)
            }
        }
    }
    
}
