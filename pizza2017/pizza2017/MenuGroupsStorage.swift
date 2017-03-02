//
//  MenuGroupsStorage.swift
//  pizza2017
//
//  Created by user on 28.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import Firebase

class MenuGroupsStorage {
    //static var image: UIImage?
    static func getImageFromStorage(callback: @escaping ()->()) -> UIImage {
        var image: UIImage?
        let storage = FIRStorage.storage().reference()
        let tempImageRef = storage.child("БезалкогольныенапиткиTueFeb0715-56-50EET2017.jpg")
        
        tempImageRef.data(withMaxSize: 1*500*300) { (data, error) in
            if error == nil {
                print("________!!!GOOD!!!_______")
                image = UIImage(data: data!)
                callback()
            } else {
                print("________ERROR_______")
                print(error?.localizedDescription)
            }
        }
        return image!
    }
    
    
    
    
//    // Зробила зразу - потім пригодиться
//    static func pushImageToStorage() {
//        let database = FIRDatabase.database().reference()
//        let storage = FIRStorage.storage().reference()
//        let tempImageRef = storage.child("tmpDir/tmpImage.jpg")
//        
//        let image = UIImage(named: "НазваФайлу.jpg")
//        
//        let metaData = FIRStorageMetadata()
//        metaData.contentType = "image/jpeg"
//        
//        tempImageRef.put(UIImageJPEGRepresentation(image!, 0.8)!, metadata: metaData) { (data, error) in
//            if error == nil {
//                print("upload successful")
//            } else {
//                print(error)
//            }
//        }
//    }
}
