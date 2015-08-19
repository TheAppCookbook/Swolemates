//
//  LoginViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    // MARK: Responders
    @IBAction func loginButtonWasPressed(sender: UIButton!) {
        let usernameRequestController = UIAlertController(title: "Venmo Username",
            message: "Please input your Venmo Username",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        usernameRequestController.addTextFieldWithConfigurationHandler(nil)
        usernameRequestController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        usernameRequestController.addAction(UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) in
            let text = (usernameRequestController.textFields?.first as? UITextField)?.text
            if text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
                return
            }
            
            PFUser.currentUser()?.venmoUsername = text
            
            self.dismissViewControllerAnimated(true,
                completion: nil)
            self.presentingViewController?.dismissViewControllerAnimated(true,
                completion: nil)
        })
        
        self.presentViewController(usernameRequestController,
            animated: true,
            completion: nil)
    }
}
