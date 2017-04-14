//
//  DishEditViewController.swift
//  pizza2017
//
//  Created by konstantin on 4/11/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class DishEditViewController: UIViewController {
    
    //MARK: Properties
    
    private var dishModel: DishModel?
    private var isNewModel = true
    private let imagePicker = UIImagePickerController()
    private var keyOfGroup: String?
    
    internal var menuGroups = [MenuGroupsModel]()
    internal var isDefaultImage = true
    internal var firebaseHelper = DishFirebase()
    
    //MARK: Outlets
    
    @IBOutlet weak var tfDishPrice: UITextField!
    @IBOutlet weak var tfDishName: UITextField!
    @IBOutlet weak var tfDishesGroupFilter: UITextField!
    @IBOutlet weak var tvDishDescription: UITextView!
    @IBOutlet weak var pvDishesGroupFilter: UIPickerView!
    @IBOutlet weak var ivDishImage: UIImageView!
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if keyOfGroup == nil {
            Utilities.showAllertMessage("Error", "Menu groups key can't be empty!", self)
            dismiss(animated: false, completion: nil)
            return
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        ivDishImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleIvDishImageTapRecognizer)))
        ivDishImage.isUserInteractionEnabled = true
        
        pvDishesGroupFilter.isHidden = isNewModel
        tfDishesGroupFilter.isHidden = isNewModel
        buttonDelete.isHidden = isNewModel
        
        fillUp()
    }
    
    //MARK: Actions
    
    func handleIvDishImageTapRecognizer() {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func onCancelClick() {
        
        closeView()
        
    }
    
    @IBAction func onOkClick() {
        
        //activityIndicator.startAnimating()
        if isNewModel {
            dishModel = DishModel()
        }
        
        let photoName = tfDishName.text!.getPhotoName()
        if !isDefaultImage || dishModel!.photoName.isEmpty {
            firebaseHelper.saveImageToFirebase(imageName: photoName, image: self.ivDishImage.image!) { (success, URL) in
                if success && URL != nil {
                    if !self.dishModel!.photoName.isEmpty && self.dishModel!.photoName != photoName {
                        self.firebaseHelper.removeImageFromStorage(imageName: self.dishModel!.photoName, callback: nil)
                    }
                    self.dishModel!.photoName = photoName
                    self.dishModel!.photoUrl = "\(URL!)"
                    self.saveDishAndClose(self.dishModel!)
                    return
                } else {
                    self.activityIndicator.stopAnimating()
                    Utilities.showAllertMessage("Allert", "Error while saving the data", self)
                }
            }
        } else {
            saveDishAndClose(dishModel!)
        }
        
    }
    
    private func saveDishAndClose(_ dish: DishModel) {
        
        dishModel!.name = tfDishName.text!
        dishModel!.price = Float(tfDishPrice.text!)!
        dishModel!.description = tvDishDescription.text!
        dishModel?.keyGroup = keyOfGroup!
        firebaseHelper.saveObject(postObject: self.dishModel as? FirebaseDataProtocol, callBack: { (error, firebaseRef, callBackObject) in
            guard error == nil else {
                self.activityIndicator.stopAnimating()
                Utilities.showAllertMessage("Allert", "Error while loading image to server", self)
                return
            }
            self.activityIndicator.stopAnimating()
            self.closeView()
        })

        
    }
    
    @IBAction func onDeleteClick(_ sender: UIButton) {
        
        if !isNewModel && dishModel != nil && !dishModel!.key.isEmpty {
            firebaseHelper.removeDish(dishModel!)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    //MARK: General Functions
    
    func setModel(_ keyOfGroup: String, _ dishModel: DishModel?) {
        
        self.keyOfGroup = keyOfGroup
        self.dishModel = dishModel
        isNewModel = dishModel == nil
        
    }
    
    private func fillUp() {
        
        guard let validModel = dishModel else {
            return
        }
        
        tfDishName.text = validModel.name
        tfDishPrice.text = "\(validModel.price)"
        tvDishDescription.text = validModel.description
        firebaseHelper.getImageFromStorage(nameOfImage: validModel.photoName, callBack: { image in
            
            self.ivDishImage.image = image
            self.isDefaultImage = true
        })
        
    }
    
    func updateButtonOkState() {
        
        buttonOk.isEnabled =  !(tfDishName.text?.isEmpty)!
            && !(tfDishPrice.text?.isEmpty)! && (!isDefaultImage || !isNewModel)
        
    }
    
    private func closeView() {
        
        if self.navigationController?.popViewController(animated: true) == nil {
            Loger.instance.writeToLog("View controller not found!")
        }
    }
    
}

extension DishEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.ivDishImage.image = pickedImage
            self.isDefaultImage = false
        }
        
        updateButtonOkState()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}

extension DishEditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        updateButtonOkState()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        updateButtonOkState()
        
    }
}

extension DishEditViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return menuGroups.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return menuGroups[row].name
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
}
