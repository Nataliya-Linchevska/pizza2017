//
//  TablesViewController.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 12.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class TablesViewController: UIViewController, TableSelectDelegate  {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var lblSelectedTabel: UIButton!
    @IBOutlet weak var btnCreateOrder: UIButton!
    
    var tables = [TableModel]()
    var tableViews = [CustomTableView]()
    
    var reservedTables = [ReservedTableModel]()
    var tablesFirebaseHelper = TablesFirebaseHelper()
    var reservedTablesFirebaseHelper = ReservedTablesFirebaseHelper()
    
    var selectedTable = ""
    var selectedTableNumber: Int?
    
    var bottomInitFrame: CGRect?
    
    var datePicker = UIDatePicker()
    
    var selectedDate: Date?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.init(patternImage: UIImage(named: "reserve_table_background")!)
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)

        
        tfDate.inputView = datePicker
        
        registerForKeyboardNotifications()
        tablesFirebaseHelper.initFirebaseObserve(key: "", callback: {
            
            self.tables = self.tablesFirebaseHelper.getTables()
            
            self.reservedTablesFirebaseHelper.initFirebaseObserve(key: "") {
                self.reservedTables = self.reservedTablesFirebaseHelper.getTables()
                
                var maxWidth = 0
                var maxHeight = 0
                
                for table in self.tables {
                    
                    let tempReserved = self.reservedTables.first(where: { (t) -> Bool in
                        t.tableKey == table.key
                    })
                    
                    let tableView = CustomTableView(frame: CGRect(x: table.xCoordinate, y: table.yCoordinate, width: table.xResolution, height: table.yResolution))
                    tableView.backgroundImage = UIImage(named: table.pictureName)
                    tableView.selectedImage = UIImage(named: "ok")
                    tableView.reservedImage = UIImage(named: "table_reserved")
                    tableView.isSelected = false
                    tableView.isReserved = tempReserved != nil
                    tableView.tableId = table.key
                    tableView.delegate = self
                    tableView.lblTableNumber?.text = table.tableId.description
                    self.tableViews.append(tableView)
                    self.scrollView.addSubview(tableView)
                    if (table.xCoordinate + table.xResolution) > maxWidth {maxWidth = table.xCoordinate + table.xResolution}
                    if (table.yCoordinate + table.yResolution) > maxHeight {maxHeight = table.yCoordinate + table.yResolution}
                    
                }
                self.scrollView.contentSize = CGSize(width: maxWidth, height: maxHeight)
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bottomInitFrame = bottomView.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func kbWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomView.frame.origin.y -= kbFrameSize.height
        
    }
    
    func kbWillHide(_ notification: NSNotification) {
        bottomView.frame = bottomInitFrame!
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        tfDate.text = formatter.string(from: sender.date)
        selectedDate = sender.date
        print("Try this at home")
    }
    
    func tableSelected(tableId: String) {
        _ = tableViews.map { (table) -> CustomTableView in
            if(table.tableId != tableId) {table.isSelected = false}
            return table
        }
        selectedTable = tableId
        let table = tables.first { (tableModel) -> Bool in
            tableModel.key == selectedTable
        }
        
        btnCreateOrder.setTitle("Заказать стол №\((table?.tableId)!)" , for: .normal)
    }
    
    @IBAction func orderTable(_ sender: UIButton) {
        
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: selectedDate!)
        let month = calendar.component(.month, from: selectedDate!)
        let day = calendar.component(.day, from: selectedDate!)
        
        let hour = calendar.component(.hour, from: selectedDate!)
        let minutes = calendar.component(.minute, from: selectedDate!)
        let seconds = calendar.component(.second, from: selectedDate!)
        
        let date = ["date": 12, "day": day, "hours": hour, "minutes": minutes, "month": month, "seconds": seconds, "time": 123123, "timezoneOffset": 0, "year": year]
        
        let reservedTable = ReservedTableModel(clientName: (UserHelper.instance.userModel?.name)!, commentClient: "", date: date, isCheckedByAdmin: 0, isNotificated: 0, key: "", phoneClient: (UserHelper.instance.userModel?.phone)!, tableKey: selectedTable, userId: (UserHelper.instance.userModel?.key)!)
        
        self.reservedTablesFirebaseHelper.saveObject(postObject: reservedTable as FirebaseDataProtocol, callBack: { (error, firebaseRef, callBackObject) in
            
            guard error == nil else {
                Utilities.showAllertMessage("", "ERROR", self)
                return
            }
        })
        
        
        
        let alert = UIAlertController(title: "", message: "Заказ отправлен", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
