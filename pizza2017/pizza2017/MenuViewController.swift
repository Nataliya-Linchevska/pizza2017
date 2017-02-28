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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
