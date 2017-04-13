//
//  AccountViewController.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 11.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {
    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var lblEmail: UITextField!
    
    @IBOutlet weak var lblName: UITextField!
    
    @IBOutlet weak var lblAddress: UITextField!
    
    @IBOutlet weak var lblPhone: UITextField!
    
    var accountFirebaseHelper = AccountFirebaseHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmail.isUserInteractionEnabled = false
        lblEmail.text = UserHelper.instance.userModel?.email
        lblName.text = UserHelper.instance.userModel?.name
        lblAddress.text = UserHelper.instance.userModel?.address
        lblPhone.text = UserHelper.instance.userModel?.phone
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
    
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveUser(_ sender: Any) {
        
        let account = UserModel(name: lblName.text!, email: lblEmail.text!, address: lblAddress.text!, phone: lblPhone.text!, key: (FIRAuth.auth()?.currentUser?.uid)!)
        
        self.accountFirebaseHelper.saveObject(postObject: account as FirebaseDataProtocol, callBack: { (error, firebaseRef, callBackObject) in
            
            guard error == nil else {
                Utilities.showAllertMessage("", "Loading image to server: ERROR", self)
                return
            }
        })

    }

}
