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
    
    internal var menuGroups = [MenuGroupsModel]()
    internal var isDefaultImage = true
    
    //MARK: Outlets
    
    @IBOutlet weak var tfDishPrice: UITextField!
    @IBOutlet weak var tfDishName: UITextField!
    @IBOutlet weak var tfDishesGroupFilter: UITextField!
    @IBOutlet weak var tvDishDescription: UITextView!
    @IBOutlet weak var pvDishesGroupFilter: UIPickerView!
    @IBOutlet weak var ivDishImage: UIImageView!
    @IBOutlet weak var buttonOk: UIButton!
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        ivDishImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleIvDishImageTapRecognizer)))
        ivDishImage.isUserInteractionEnabled = true
        
        
        pvDishesGroupFilter.isHidden = isNewModel
        tfDishesGroupFilter.isHidden = isNewModel
        
        fillUp()
    }
    
    //MARK: Actions
    
    func handleIvDishImageTapRecognizer() {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func onCancelClick() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onOkClick() {
        
    }
    
    //MARK: Functions
    
    func setModel(_ dishModel: DishModel?) {
        
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
        
    }
    
    func updateOkAndPhotoName() {
        
        buttonOk.isEnabled = !((tfDishName.text?.isEmpty)! || (tfDishPrice.text?.isEmpty)! || isDefaultImage)
        
    }
    
}

extension DishEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.ivDishImage.image = pickedImage
            self.isDefaultImage = false
        }
        
        updateOkAndPhotoName()
        
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
        
        updateOkAndPhotoName()
        
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
