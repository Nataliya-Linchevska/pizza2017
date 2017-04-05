//
//  BacketViewController.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 05.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class BacketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView?
    var firebaseHelper = DishesGroupFirebase()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BacketHelper.backetDishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BacketCell", for: indexPath) as! BacketTableViewCell
        
        cell.lblTitle?.text = BacketHelper.backetDishes[indexPath.row].name
        cell.lblPrice?.text = BacketHelper.backetDishes[indexPath.row].price.description
        firebaseHelper.getImageFromStorage(nameOfImage: BacketHelper.backetDishes[indexPath.row].photoName, callBack: { image in
            cell.imgDishImage?.image = image
        })

        return cell
    }

}
