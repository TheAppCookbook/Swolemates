//
//  PostDescriptionViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import CoreLocation

class PostDescriptionViewController: PostViewController {
    // MARK: Properties
    @IBOutlet var titleField: UITextField!
    @IBOutlet var priceField: UITextField!
    @IBOutlet var equipmentField: UITextField!
    @IBOutlet var streetAddressField: UITextField!
    @IBOutlet var zipCodeField: UITextField!
    @IBOutlet var photoButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    
    private var photo: UIImage?
    private var inputValid: Bool {
        return (self.titleField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            ((self.priceField.text as NSString?)?.integerValue > 0) &&
            (self.equipmentField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            (self.streetAddressField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            (CLLocation.validateUSZipCode(self.zipCodeField.text ?? "")) &&
            (self.photo != nil)
    }
    
    // MARK: Lifecycle
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        switch segue.identifier {
        case .Some("SetAvailability"):
            if let destinationVC = segue.destinationViewController as? PostAvailabilityViewController {
                destinationVC.postTitle = self.titleField.text
                destinationVC.postPrice = (self.priceField.text as NSString?)?.integerValue
                destinationVC.postStreetAddress = self.streetAddressField.text
                destinationVC.postZipCode = self.zipCodeField.text
                destinationVC.postPhoto = self.photo
                destinationVC.postEquipment = self.equipmentField.text
            }
            
        default:
            break
        }
    }
    
    // MARK: Responders
    @IBAction func photoButtonWasPressed(sender: UIButton!) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .SavedPhotosAlbum
        
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController,
            animated: true,
            completion: nil)
    }
    
    private func inputDidChange() {
        self.doneButton.enabled = self.inputValid
        self.doneButton.backgroundColor = self.doneButton.enabled ? self.doneButton.tintColor : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    }
}

extension PostDescriptionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.photo = (info[UIImagePickerControllerOriginalImage] as? UIImage)
        self.photoButton.setTitle("Change Photo", forState: .Normal)
        
        self.inputDidChange()
        self.dismissViewControllerAnimated(true,
            completion: nil)
    }
}

extension PostDescriptionViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.inputDidChange()
        return true
    }
}