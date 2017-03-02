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
    
    
    
    
//    // Кидаю зразок - потім пригодиться
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

