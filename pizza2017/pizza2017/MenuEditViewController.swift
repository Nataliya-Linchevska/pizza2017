//
//  MenuEditViewController.swift
//  pizza2017
//
//  Created by konstantin on 3/26/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit
import AssetsLibrary

class MenuEditViewController: UIViewController {
    
    //MARK: Properties
    
    private let imagePicker = UIImagePickerController()
    private var menuGroup: MenuGroupsModel?
    private var isNewModel = true
    private var firebaseHelper = MenuGroupsFirebase()
    
    var isDefaultImage = true
        
    //MARK: Outlets
    
    @IBOutlet weak var tfGroupName: UITextField!
    @IBOutlet weak var lbGroupName: UILabel!
    @IBOutlet weak var ivGroupImage: UIImageView!
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tfGroupName.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        ivGroupImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleIvGroupImageTapRecognizer)))
        ivGroupImage.isUserInteractionEnabled = true
        
        fillUp()
        
    }
    
    //MARK: General function
    
    func setModel(_ inputMenuGroup: MenuGroupsModel?) {
        
        menuGroup = inputMenuGroup
        isNewModel = inputMenuGroup == nil
    }
    
    private func fillUp() {
       
        if isNewModel {
            
            buttonOK.isEnabled = false
            return
        }

        firebaseHelper.getImageFromStorage(nameOfImage: menuGroup!.photoName, callBack: { image in
            
            self.ivGroupImage.image = image
            self.isDefaultImage = false
        })
        
        tfGroupName.text = menuGroup!.name
        
    }
    
    func updateOkAndPhotoName() {
        
        lbGroupName.text = tfGroupName.text
        buttonOK.isEnabled = !(tfGroupName.text?.isEmpty)! && !isDefaultImage
        
    } 
    
    
    //MARK: Actions
    
    func handleIvGroupImageTapRecognizer() {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonOKClick() {
       
        activityIndicator.startAnimating()
        if isNewModel {
            menuGroup = MenuGroupsModel()
        }
        
        let groupName = tfGroupName.text!
        let photoName = groupName.getPhotoName()
        firebaseHelper.saveImageToFirebase(imageName: photoName,
                                           image: self.ivGroupImage.image!) { (success, URL) in
            if success && URL != nil {
                
                //if image changed
                //delete old image if exist
               
                self.menuGroup!.name = groupName
                self.menuGroup!.photoName = photoName
                self.menuGroup!.photoUrl = "\(URL!)"                
                self.firebaseHelper.saveObject(postObject: self.menuGroup as? FirebaseDataProtocol, callBack: { (error, firebaseRef, callBackObject) in
                    
                    guard error == nil else {
                        self.activityIndicator.stopAnimating()
                        Utilities.showAllertMessage("Allert", "Loading image to server: ERROR", self)
                        return
                    }
                    self.activityIndicator.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                })
                return
            } else {
                self.activityIndicator.stopAnimating()
                Utilities.showAllertMessage("Allert", "Error while saving the data", self)
                

            }
        }        
        
    }
    
    @IBAction func buttonCancelClick() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func groupNameChanged(_ sender: UITextField) {
        
        updateOkAndPhotoName()
        
    }
}

extension MenuEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.ivGroupImage.image = pickedImage
            self.isDefaultImage = false
        }
        
        updateOkAndPhotoName()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}

extension MenuEditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        updateOkAndPhotoName()
        
    }
}
