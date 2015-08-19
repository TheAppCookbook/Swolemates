//
//  BorderedButton.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

@IBDesignable class BorderedButton: UIButton {
    // MARK: Properties
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(CGColor: self.layer.borderColor) }
        set { self.layer.borderColor = newValue?.CGColor }
    }
    
    var associatedIndex: Int?
}
