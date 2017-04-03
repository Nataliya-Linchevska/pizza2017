//
//  Utilities.swift
//  pizza2017
//
//  Created by konstantin on 4/3/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func doSomethingAsync(_ someFunc: @escaping () -> ()) {
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                someFunc()
            }
        }
    }
    
    static func showAllertMessage(_ message: String, _ viewController: UIViewController) {
        
        /*doSomethingAsync {*/
            
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
            
        /*}*/
    }
    
}
