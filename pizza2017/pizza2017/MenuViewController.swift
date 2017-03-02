//
//  MenuViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var willDeleteImageView: UIImageView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    struct MenuObject {
        var menuGroupTitle: String
        var menuGroupImage: UIImage
        init(menuGroupTitle: String, menuGroupImage: UIImage) {
            self.menuGroupTitle = menuGroupTitle
            self.menuGroupImage = menuGroupImage
        }
    }
    var menuArray: [MenuObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        MenuGroupsFirebase.getTasksFromFirebase()
        
        let database = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference()
        let tempImageRef = storage.child("БезалкогольныенапиткиTueFeb0715-56-50EET2017.jpg")
        
        tempImageRef.data(withMaxSize: 1*500*300) { (data, error) in
            if error == nil {
                print("________!!!GOOD!!!_______")
                print(data)
                self.willDeleteImageView.image = UIImage(data: data!)
            } else {
                print("________ERROR_______")
                print(error?.localizedDescription)
            }
        }
        
        menuArray.append(MenuObject(menuGroupTitle: "first title", menuGroupImage: UIImage(named: "logoPizza")!))
        menuArray.append(MenuObject(menuGroupTitle: "second title", menuGroupImage: UIImage(named: "logoPizza")!))
        menuArray.append(MenuObject(menuGroupTitle: "third title", menuGroupImage: UIImage(named: "logoPizza")!))
        menuArray.append(MenuObject(menuGroupTitle: "fourth title", menuGroupImage: UIImage(named: "logoPizza")!))

        CollectionView.delegate = self
        CollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuGroupCell", for: indexPath) as! MenuGroupsCollectionViewCell
        cell.lblTitle.text = menuArray[indexPath.item].menuGroupTitle
        cell.ivImage.image = menuArray[indexPath.item].menuGroupImage
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
