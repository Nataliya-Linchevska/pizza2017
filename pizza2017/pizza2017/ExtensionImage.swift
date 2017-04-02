//
//  ExtensionImage.swift
//  pizza2017
//
//  Created by konstantin on 4/2/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

extension UIImage {
    
    func compressImage() -> UIImage {
        
        var actualHeight : CGFloat = self.size.height
        var actualWidth : CGFloat = self.size.width
        let maxHeight : CGFloat = 300.0
        let maxWidth : CGFloat = 500.0
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        if actualHeight > maxHeight || actualWidth > maxWidth {
            
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let canvasSize = CGSize(width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        UIGraphicsEndImageContext();
        return result
    }
    
    
    func compressImage(compressionQuality : CGFloat) -> Data? {
        return UIImageJPEGRepresentation(compressImage(), compressionQuality);
    }
    
    /*func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }*/
    
}
