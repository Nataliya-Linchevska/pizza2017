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
    
    override func viewDidLoad() {
        SettingsFirebase.getTasksFromFirebase {
            self.reloadView(taskSettings: SettingsFirebase.taskSettings!)
        }
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
    
    func reloadView(taskSettings: SettingsModel) {
        let taskSettings = taskSettings
        lblAddress.text = taskSettings.address
        lblEmail.text = "Email: " + taskSettings.email
        lblPhone.text = "Телефон: " + taskSettings.phone
    }
}
