//
//  ExtensionString.swift
//  pizza2017
//
//  Created by konstantin on 3/28/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

extension String {
    
    func getPhotoName() -> String {
        
        return "\(self.replacingOccurrences(of: " ", with: ""))" +
               "\(Date().dateStringWithFormat(format: "EEEMMMddhh-mm-ssyyyy"))" +
               ".jpg"
    }
    
    public func toDateTime() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFromString = dateFormatter.date(from: self)!
        return dateFromString
    }
    
}
