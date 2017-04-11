//
//  RegistrationViewController.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 10.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class RegistrationViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var accountFirebaseHelper = AccountFirebaseHelper()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func createAccountAction(_ sender: AnyObject) {
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    UserHelper.instance.userModel = UserModel(name: self.nameTextField.text!, email: self.emailTextField.text!, address: self.addressTextField.text!, phone: self.phoneTextField.text!, key: (FIRAuth.auth()?.currentUser?.uid)!)
                    
                    self.accountFirebaseHelper.saveObject(postObject: UserHelper.instance.userModel!, callBack: { (error, firebaseRef, callBackObject) in
                        
                        guard error == nil else {
                            Utilities.showAllertMessage("", "Loading image to server: ERROR", self)
                            return
                        }
                    })
                    self.performSegue(withIdentifier: "Registration", sender: self)
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }

}
