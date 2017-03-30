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
    internal var imageURL: NSURL?
    
    //MARK: Outlets
    
    @IBOutlet weak var tfGroupName: UITextField!
    @IBOutlet weak var lbGroupName: UILabel!
    @IBOutlet weak var ivGroupImage: UIImageView!
    @IBOutlet weak var buttonOK: UIButton!
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfGroupName.delegate = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        fillUp()
        
    }
    
    //MARK: General function
    
    func setModel(_ inputMenuGroup: MenuGroupsModel?) {
        
        menuGroup = inputMenuGroup
        if menuGroup != nil {
            isNewModel = false
        }
    }
    
    private func fillUp() {
        
        buttonOK.isEnabled = false
        
        if isNewModel { return }

        firebaseHelper.getImageFromStorage(nameOfImage: menuGroup!.photoName, callBack: { image in
                self.ivGroupImage.image = image
        })
        
        imageURL = NSURL(fileURLWithPath: menuGroup!.photoUrl)
        tfGroupName.text = menuGroup!.name
        
    }
    
    func updateOkAndPhotoName() {
        
        lbGroupName.text = tfGroupName.text
        buttonOK.isEnabled = !(tfGroupName.text?.isEmpty)! && imageURL != nil
        
    }
    
    func showAllertMessage(message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: Actions
    
    @IBAction func buttonImageClick() {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonOKClick() {
       
        if isNewModel {
            menuGroup = MenuGroupsModel()
        }
        
        if imageURL == nil {
            return
        }
        
        let fileName = imageURL!.lastPathComponent!.getPhotoName()
        let imagePath =  imageURL!.path!
        //let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imagePath)
        firebaseHelper.saveImageToStorage(imageName: fileName, localPath: imagePath) { (isError, URL) in
            if isError {
                self.showAllertMessage(message: "Loading image to server: ERROR")
            } else {
                if self.isNewModel {
                    self.menuGroup!.key = self.firebaseHelper.getNewRecordKey()
                } else {
                    //delete old image if exist
                }
                self.menuGroup!.name = self.tfGroupName.text!
                self.menuGroup!.photoName = fileName
                self.menuGroup!.photoUrl = (URL?.absoluteString)!
                self.firebaseHelper.saveObject(key: self.menuGroup!.key, value: self.menuGroup!)
                
            }
        }
        dismiss(animated: true, completion: nil)
        
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
        
        if let referenceUrl = info[UIImagePickerControllerReferenceURL] as? NSURL {
            imageURL = referenceUrl
        } else {
            imageURL = nil
        }
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.ivGroupImage.image = pickedImage
        }
        
        updateOkAndPhotoName()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
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
