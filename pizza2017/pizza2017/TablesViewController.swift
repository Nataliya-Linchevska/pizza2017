//
//  TablesViewController.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 12.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class TablesViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var tables = [TableModel]()
    var reservedTables = [ReservedTableModel]()
    var tablesFirebaseHelper = TablesFirebaseHelper()
    var reservedTablesFirebaseHelper = ReservedTablesFirebaseHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.init(patternImage: UIImage(named: "reserve_table_background")!)
        
        tablesFirebaseHelper.initFirebaseObserve(key: "", callback: {
            
            self.tables = self.tablesFirebaseHelper.getTables()
            
            for table in self.tables {
                let tableView = CustomTableView(frame: CGRect(x: table.xCoordinate, y: table.yCoordinate, width: table.xResolution, height: table.yResolution))
                tableView.backgroundImage = UIImage(named: table.pictureName)
                tableView.selectedImage = UIImage(named: "ok")
                tableView.isSelected = false
                
                self.scrollView.addSubview(tableView)
            }
            
            print(self.tables)
            
        })
        
        reservedTablesFirebaseHelper.initFirebaseObserve(key: "") { 
            self.reservedTables = self.reservedTablesFirebaseHelper.getTables()
            print(self.reservedTables)
        }

        
        scrollView.contentSize = CGSize(width: 2000, height: 2000)

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
    @IBAction func orderTable(_ sender: UIButton) {
        
        var date = ["date": 11, "day": 11, "hours": 11, "minutes": 11, "month": 11, "seconds": 11, "time": 1487936119418, "timezoneOffset": 11, "year": 11]
        
        var reservedTable = ReservedTableModel(clientName: (UserHelper.instance.userModel?.name)!, commentClient: "", date: date, isCheckedByAdmin: 0, isNotificated: 0, key: "", phoneClient: (UserHelper.instance.userModel?.phone)!, tableKey: "rtyh", userId: (UserHelper.instance.userModel?.key)!)
        
        self.reservedTablesFirebaseHelper.saveObject(postObject: reservedTable as FirebaseDataProtocol, callBack: { (error, firebaseRef, callBackObject) in
            
            guard error == nil else {
                Utilities.showAllertMessage("", "Loading image to server: ERROR", self)
                return
            }
        })
        
        
        
        let alert = UIAlertController(title: "", message: "Заказ отправлен", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
