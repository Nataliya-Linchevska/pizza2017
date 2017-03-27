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
    
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var firebaseHelper = MenuGroupsFirebase()
        
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseHelper.initFirebaseObserve {
            self.CollectionView.reloadData()
        }
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        if !UserHelper.instance.isAdminLogged {
            topNavigationItem.rightBarButtonItem = nil
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitFirebaseObserve()
    }
    
    //MARK: Actions
  
    @IBAction func addMenuGroupClick(_ sender: UIBarButtonItem) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "MenuEditViewController") as! MenuEditViewController
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
        cell.lblTitle.text = menuGroup.name
        
        firebaseHelper.getImageFromStorage(nameOfImage:
            String(menuGroup.photoName), callBack: { image in
            cell.ivImage.image = image
        })
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DishesGroup") as! DishesGroupViewController
        // Передаю ключ їжі який відображати в наступному контроллері
        controller.keyForDish = firebaseHelper.getMenuGroup(indexPath.item).key
        
        navigationController?.pushViewController(controller, animated: true)
    }

    
}
