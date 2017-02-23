//
//  SettingsViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    var taskSettings = SettingsFirebase.taskSettings

    override func viewDidLoad() {
        super.viewDidLoad()
        SettingsFirebase.getTasksFromFirebase()
        lblAddress.text = taskSettings?.address
        print(taskSettings?.address)
        lblEmail.text = taskSettings?.email
        print(taskSettings?.email)
        lblPhone.text = taskSettings?.phone
        print(taskSettings?.phone)
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
