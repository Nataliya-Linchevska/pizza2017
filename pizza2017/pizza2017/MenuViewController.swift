//
//  MenuViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuGroupsFirebase.getTasksFromFirebase { 
            self.CollectionView.reloadData()
        }
    
        CollectionView.delegate = self
        CollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuGroupsFirebase.arrayOfTaskMenuGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuGroupCell", for: indexPath) as! MenuGroupsCollectionViewCell
        
        cell.lblTitle.text = MenuGroupsFirebase.arrayOfTaskMenuGroups[indexPath.item].name
        
        MenuGroupsStorage.getImageFromStorage(nameOfImage: String(MenuGroupsFirebase.arrayOfTaskMenuGroups[indexPath.item].photoName) , callBack: { image in
            cell.ivImage.image = image
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DishesGroup") as! DishesGroupViewController
        // Передаю ключ їжі який відображати в наступному контроллері
        controller.keyForDish = MenuGroupsFirebase.arrayOfTaskMenuGroups[indexPath.item].key
        
        navigationController?.pushViewController(controller, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
