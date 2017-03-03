//
//  DishesGroupStorage.swift
//  pizza2017
//
//  Created by user on 03.03.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class DishesGroupStorage {
    static func getImageFromStorage(nameOfImage: String, callBack: @escaping (_ image: UIImage) -> ()) {
        let storage = FIRStorage.storage().reference()
        let tempImageRef = storage.child(nameOfImage)
        
        tempImageRef.data(withMaxSize: 1*500*300) { (data, error) in
            if error == nil {
                callBack(UIImage(data: data!)!)
            } else {
                print(error?.localizedDescription ?? "unhandled error")
            }
        }
    }
}
