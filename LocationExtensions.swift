//
//  LocationExtensions.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D {
    // MARK: Initializers
    init(string: String) {
        var trimmedString = string.stringByTrimmingCharactersInSet(NSCharacterSet.punctuationCharacterSet())
        var coordinates = trimmedString.componentsSeparatedByString(",") as [NSString]
        self.init(latitude: CLLocationDegrees(coordinates[0].doubleValue),
            longitude: CLLocationDegrees(coordinates[1].doubleValue))
    }
    
    // MARK: Accessors
    func toString() -> String {
        return "{\(self.latitude),\(self.longitude)}"
    }
}

extension CLLocation {
    // MARK: Class Accessors
    class func validateUSZipCode(zipCode: String) -> Bool {
        let regex = NSRegularExpression(pattern: "^\\d{5}(-\\d{4})?$",
            options: nil,
            error: nil)
        
        return regex?.matchesInString(zipCode,
            options: nil,
            range: NSMakeRange(0, zipCode.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))).count > 0
    }
}