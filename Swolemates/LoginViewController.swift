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
    // MARK: Properties
    @IBOutlet var emailInputField: UITextField!
    @IBOutlet var passwordInputField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var detailTextLabel: UILabel!
    @IBOutlet var forgotPasswordButton: UIButton!
    
    private var inputValid: Bool {
        return (self.emailInputField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            (self.passwordInputField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0)
    }
    
    // MARK: Responders
    @IBAction func registerButtonWasPressed(sender: UIButton!) {
        self.emailInputField.resignFirstResponder()
        self.passwordInputField.resignFirstResponder()
        
        let successHandler = {
            self.presentingViewController?.dismissViewControllerAnimated(true,
                completion: nil)
        }
        
        if let currentUser = PFUser.currentUser() {
            self.registerButton.hidden = true
            self.activityIndicator.startAnimating()
            
            let email = self.emailInputField.text!
            let password = self.passwordInputField.text!
            
            PFUser.logInWithUsernameInBackground(email, password: password) { (user: PFUser?, error: NSError?) in
                if user != nil {
                    PFUser.become(user!.sessionToken!)
                    successHandler()
                } else {
                    currentUser.email = email
                    currentUser.username = email
                    currentUser.password = password
                    
                    currentUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
                        if success {
                            PFUser.become(currentUser.sessionToken!)
                            successHandler()
                        } else {
                            self.registerButton.hidden = false
                            self.activityIndicator.stopAnimating()
                            
                            self.detailTextLabel.text = "Whoops! Something went wrong 🙊"
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func forgotPasswordButtonWasPressed(sender: UIButton!) {
        PFUser.requestPasswordResetForEmailInBackground(self.emailInputField.text!, block: { (success: Bool, error: NSError?) in
            if success {
                self.detailTextLabel.text = "Alright! Go check your email 🐵"
            } else {
                self.detailTextLabel.text = "Drat! Something went wrong 🙉"
            }
        })
    }
    
    func inputChanged() {
        self.registerButton.enabled = self.inputValid
        self.registerButton.alpha = self.registerButton.enabled ? 1.0 : 0.5
        
        self.forgotPasswordButton.hidden = (self.emailInputField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.inputChanged()
        return true
    }
}