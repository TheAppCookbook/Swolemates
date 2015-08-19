//
//  CreateListingViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class CreateListingViewController: UITableViewController {
    // MARK: Properties
    @IBOutlet var titleField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var priceField: UITextField!
    @IBOutlet var doneButton: UIButton!
    
    private var photo: UIImage? {
        didSet {
            self.inputChanged()
            self.photoView?.image = self.photo
        }
    }
    
    private var price: Int {
        return (self.priceField.text as NSString?)?.integerValue ?? 0
    }
    
    private var inputValid: Bool {
        return (self.titleField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            (self.descriptionField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            (self.photo != nil) &&
            (self.priceField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0)
    }
    
    // MARK: Responders
    @IBAction func photoImageTapGestureWasRecognized(gestureRecognizer: UITapGestureRecognizer!) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        
        self.presentViewController(imagePicker,
            animated: true,
            completion: nil)
    }
    
    @IBAction func doneButtonWasPressed(sender: UIButton!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        let listing = GymListing(title: self.titleField.text!,
            description: self.descriptionField.text!,
            price: self.price)
        
        listing.setPhoto(self.photo!) { (imageURL: NSURL?) in
            listing.saveAndNotify()
        }
    }
    
    func inputChanged() {
        self.doneButton.enabled = self.inputValid
        self.doneButton.alpha = self.doneButton.enabled ? 1.0 : 0.5
    }
}

extension CreateListingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true,
            completion: nil)
    }
}

extension CreateListingViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.inputChanged()
        return true
    }
}
