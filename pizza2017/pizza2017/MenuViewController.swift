//
//  MenuViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var buttonAddMenuGroup: UIBarButtonItem!
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuGroupsFirebase.instance.reloadMenuGroups {
            self.CollectionView.reloadData()
        }
    
        CollectionView.delegate = self
        CollectionView.dataSource = self
        buttonAddMenuGroup.isEnabled = UserHelper.instance.isAdminLogged
    }

}

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuGroupsFirebase.instance.getMenuGroups().count
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuGroupCell", for: indexPath) as! MenuGroupsCollectionViewCell
        
        let menuGroup = MenuGroupsFirebase.instance.getMenuGroup(indexPath.item)
        cell.lblTitle.text = menuGroup.name
        
        MenuGroupsFirebase.instance.getImageFromStorage(nameOfImage:
            String(menuGroup.photoName), callBack: { image in
            cell.ivImage.image = image
        })
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DishesGroup") as! DishesGroupViewController
        // Передаю ключ їжі який відображати в наступному контроллері
        controller.keyForDish = MenuGroupsFirebase.instance.getMenuGroup(indexPath.item).key
        
        navigationController?.pushViewController(controller, animated: true)
    }

    
}
