//
//  SwoleStyles.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Foundation

extension UIFont {
    // MARK: Class Accessors
    class func swoleSemiBoldFontWithSize(size: CGFloat) -> UIFont! {
        return UIFont(name: "OpenSans-Semibold", size: size)!
    }
}

extension UIColor {
    // MARK: Class Accessors
    class func swoleLightColor() -> UIColor {
        return UIColor(red: 0.63,
            green: 0.69,
            blue: 0.73,
            alpha: 1.00)
    }
}