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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        footerView.backgroundColor = UIColor.red
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 150, height: 40))
        button.backgroundColor = UIColor.green
        button.setTitle("ОФОРМИТЬ", for: .normal)
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(createOrder), for: .touchUpInside)
        
        let label = UILabel(frame: CGRect(x: button.frame.width + 20, y: 10, width: 150, height: 40))
        var sum = 0.0
        _ = BacketHelper.backetDishes.map({ (m) in
            sum += Double(m.price)
        })

        label.text = sum.description
        footerView.addSubview(button)
        footerView.addSubview(label)
        
        return footerView
    }
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            BacketHelper.backetDishes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    func createOrder() {
        BacketHelper.backetDishes.removeAll()
        tableView?.reloadData()
        let alert = UIAlertController(title: "", message: "Заказ отправлен", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
