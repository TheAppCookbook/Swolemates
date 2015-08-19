//
//  DateExtensions.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Foundation

extension NSDate {
    // MARK: Accessors
    func stringWithFormat(dateFormat: NSDateFormatterStyle = .NoStyle, timeFormat: NSDateFormatterStyle = .NoStyle) -> String {
        let formatter = NSDateFormatter()
        
        formatter.dateStyle = dateFormat
        formatter.timeStyle = timeFormat
        
        return formatter.stringFromDate(self)
    }
}