//
//  BacketViewController.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 05.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit


enum BacketStyle: Int {
    case backet //0
    case orderList //1
}


class BacketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView?
    var dishesFirebaseHelper = DishFirebase()
    var deliveryHelper = DeliveryFirebase()
    
    var backetStyle = BacketStyle.backet
    
    var deliveries = [DeliveryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        //activityIndicator.startAnimating()
        deliveryHelper.initFirebaseObserve(dishKey: "", callback: {
            
            self.deliveries = self.deliveryHelper.getDeliveries()
            self.tableView?.reloadData()
            
        })

    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return backetStyle == .backet ? 60 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        let segmentController = UISegmentedControl(items: ["Корзина", "Список заказов"])
        segmentController.frame = CGRect(x: 10, y: 5, width: tableView.frame.width - 20, height: 30)
        segmentController.selectedSegmentIndex = backetStyle.rawValue
        segmentController.addTarget(self, action: #selector(self.segmentChanged(sender:)), for: .valueChanged)
        headerView.addSubview(segmentController)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if backetStyle != .backet {return nil}
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))

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
        return backetStyle == .backet ? BacketHelper.backetDishes.count : deliveries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (backetStyle == .backet) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BacketCell", for: indexPath) as! BacketTableViewCell
            
            cell.lblTitle?.text = BacketHelper.backetDishes[indexPath.row].name
            cell.lblPrice?.text = BacketHelper.backetDishes[indexPath.row].price.description
            dishesFirebaseHelper.getImageFromStorage(nameOfImage: BacketHelper.backetDishes[indexPath.row].photoName, callBack: { image in
                cell.imgDishImage?.image = image
            })
            
            return cell
        } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCell", for: indexPath) as! DeliveryTableViewCell
            cell.lblPrice?.text = deliveries[indexPath.row].totalSum
            cell.lblTitle?.text = deliveries[indexPath.row].name
            return cell
        }

        
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
        
        var sum = 0.0
        var keysDishes = [String]()
        var numbersDishes = [String]()
        _ = BacketHelper.backetDishes.map({ (m) in
            sum += Double(m.price)
            keysDishes.append(m.key)
            numbersDishes.append("1")
        })
        
        let delivery = DeliveryModel(name: (UserHelper.instance.userModel?.name)!, addressClient: (UserHelper.instance.userModel?.address)!, commentClient: "", keysDishes: keysDishes, latitude: 100.description, longitude: 100.description, nameClient: "sadf", numbersDishes: numbersDishes, paid: "false", phoneClient: "", totalSum: sum.description, userEmail: (UserHelper.instance.userModel?.email)!, userId: (UserHelper.instance.userModel?.key)!)
        
        self.deliveryHelper.saveObject(postObject: delivery as FirebaseDataProtocol, callBack: { (error, firebaseRef, callBackObject) in
            
            guard error == nil else {
                Utilities.showAllertMessage("", "Loading image to server: ERROR", self)
                return
            }
        })

        
        BacketHelper.backetDishes.removeAll()
        tableView?.reloadData()
        let alert = UIAlertController(title: "", message: "Заказ отправлен", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        backetStyle = BacketStyle(rawValue: sender.selectedSegmentIndex)!
        tableView?.reloadData()
        
    }

}
