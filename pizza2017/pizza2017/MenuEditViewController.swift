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
            self.isDefaultImage = true
        })
        
        tfGroupName.text = menuGroup!.name
        
    }
    
    func updateOkAndPhotoName() {
        
        buttonOK.isEnabled = !(tfGroupName.text?.isEmpty)! && (!isDefaultImage || !isNewModel)
        
    }
    
    private func saveMenuGroupAndClose(_ menuGroup: MenuGroupsModel) {
        
        menuGroup.name = tfGroupName.text!
        firebaseHelper.saveObject(postObject: self.menuGroup as? FirebaseDataProtocol, callBack: { (error, firebaseRef, callBackObject) in
            guard error == nil else {
                self.activityIndicator.stopAnimating()
                Utilities.showAllertMessage("Allert", "Error while loading image to server", self)
                return
            }
            self.activityIndicator.stopAnimating()
            self.closeView()
        })
    }
    
    private func closeView() {
        
        if self.navigationController?.popViewController(animated: true) == nil {
            Loger.instance.writeToLog("View controller not found!")
        }
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
        
        let newPhotoName = tfGroupName.text!.getPhotoName()
        
        if !isDefaultImage || menuGroup!.photoName.isEmpty {
            firebaseHelper.saveImageToFirebase(imageName: newPhotoName, image: self.ivGroupImage.image!) { (success, URL) in
                if success && URL != nil {
                    if !self.menuGroup!.photoName.isEmpty && self.menuGroup!.photoName != newPhotoName {
                        self.firebaseHelper.removeImageFromStorage(imageName: self.menuGroup!.photoName, callback: nil)
                    }
                    self.menuGroup!.photoName = newPhotoName
                    self.menuGroup!.photoUrl = "\(URL!)"
                    self.saveMenuGroupAndClose(self.menuGroup!)
                    return
                } else {
                    self.activityIndicator.stopAnimating()
                    Utilities.showAllertMessage("Allert", "Error while saving the data", self)
                }
            }
        } else {
            saveMenuGroupAndClose(menuGroup!)
        }
        
    }
    
    @IBAction func buttonCancelClick() {
        
        closeView()        
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        updateOkAndPhotoName()
        
    }
}
