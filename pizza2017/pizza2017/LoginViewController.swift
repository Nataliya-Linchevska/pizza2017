//
//  LoginViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnGuest: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let accountFirebaseHelper = AccountFirebaseHelper()
        let settingsFireBase = SettingsFirebase()
        if FIRAuth.auth()?.currentUser != nil {
            accountFirebaseHelper.initFirebaseObserve(userKey: (FIRAuth.auth()?.currentUser?.uid)!, callback: {
                UserHelper.instance.userModel = accountFirebaseHelper.getUser(0)
                settingsFireBase.initFirebaseObserve { (settings) in
                        UserHelper.instance.isAdminLogged = settings.adminEmail == UserHelper.instance.userModel?.email
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "Login", sender: self)
                    }
                }
            })
   
        } else {
            
        }
        
        // фон
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor(colorLiteralRed: 21/255.0, green: 136/255.0, blue: 18/255.0, alpha: 1).cgColor, UIColor(colorLiteralRed: 254/255.0, green: 244/255.0, blue: 85/255.0, alpha: 1).cgColor]
        gradientView.layer.addSublayer(gradient)
        
        // заокруглення
        btnLogIn.layer.cornerRadius = 22
        btnRegister.layer.cornerRadius = 22
        btnGuest.layer.cornerRadius = 22
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
//        self.performSegue(withIdentifier: "Login", sender: self)
//        return
        
        let accountFirebaseHelper = AccountFirebaseHelper()
        let settingsFireBase = SettingsFirebase()
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    
                    
                    accountFirebaseHelper.initFirebaseObserve(userKey: (FIRAuth.auth()?.currentUser?.uid)!, callback: {
                        
                        UserHelper.instance.userModel = accountFirebaseHelper.getUser(0)
                        settingsFireBase.initFirebaseObserve { (settings) in
                            UserHelper.instance.isAdminLogged = settings.adminEmail == UserHelper.instance.userModel?.email
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "Login", sender: self)
                            }
                        }
                                                
                    })

                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func anonimAction(_ sender: AnyObject) {
        UserHelper.instance.isAdminLogged = false
        UserHelper.instance.userModel = nil
        self.performSegue(withIdentifier: "Login", sender: self)
    }

}
