//
//  UserExtensions.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse

extension PFUser {
    // MARK: Properties
    var venmoUsername: String? {
        get { return NSUserDefaults.standardUserDefaults().stringForKey("PFUser.venmoUsername") }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "PFUser.venmoUsername")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
