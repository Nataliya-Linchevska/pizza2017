//
//  ExtensionDate.swift
//  pizza2017
//
//  Created by konstantin on 3/28/17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import Foundation

extension Date {
    
    public func equalToDate(dateToCompare: Date) -> Bool {
        
        return self.compare(dateToCompare) == ComparisonResult.orderedSame
    }
    
    public func dateTimeToString() -> String {
        return dateStringWithFormat(format: "yyyy-MM-dd hh:mm:ss")
    }
    
    public func dateStringWithFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
