//
//  MenuEditViewController.swift
//  pizza2017
//
//  Created by konstantin on 3/26/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class MenuEditViewController: UIViewController {
    
    //MARK: Properties
    
    let imagePicker = UIImagePickerController()
    private var menuGroup: MenuGroupsModel?
    private var isNewModel = true
    
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
        buttonOK.isEnabled = false
        
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
        
        if isNewModel { return }
        
        tfGroupName.text = menuGroup!.name
        
    }
    
    
    //MARK: Actions
    
    @IBAction func buttonImageClick() {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonOKClick() {
       
        if isNewModel {
            menuGroup = MenuGroupsModel()
        }
        
        menuGroup!.name = tfGroupName.text!
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonCancelClick() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func groupNameChanged(_ sender: UITextField) {
        
        if let validText = sender.text {
            buttonOK.isEnabled = !validText.isEmpty
        }
        lbGroupName.text = sender.text
        
    }
    
}

extension MenuEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.ivGroupImage.image = pickedImage
        }
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
}
