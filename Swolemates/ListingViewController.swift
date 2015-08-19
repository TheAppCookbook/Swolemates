//
//  ListingViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import GradientView
import Parse

class ListingViewController: UITableViewController {
    // MARK: Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var topGradientView: GradientView!
    @IBOutlet var bottomGradientView: GradientView!
    
    @IBOutlet var descriptionLabel: UILabel!    
    @IBOutlet var contactButton: UIButton!
    
    var listing: GymListing?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layoutMargins = UIEdgeInsets()
        
        self.titleLabel.text = self.listing!.title
        self.imageView.setImageWithURL(self.listing!.photoURL)
        self.priceLabel.text = "$\(self.listing!.price)/hr"
        
        self.topGradientView.colors = [
            UIColor(white: 0.0, alpha: 0.6),
            UIColor(white: 0.0, alpha: 0.0)
        ]
        
        self.bottomGradientView.colors = [
            UIColor(white: 0.0, alpha: 0.0),
            UIColor(white: 0.0, alpha: 0.6)
        ]
        
        self.descriptionLabel.text = self.listing!.listingDescription
        
        if self.listing?.email != PFUser.currentUser()?.email {
            self.contactButton.setTitle("Contact \(self.listing!.username)", forState: .Normal)
        } else { // Become Delete button
            self.contactButton.setTitle("Delete Listing", forState: .Normal)
            self.contactButton.backgroundColor = UIColor(red: 0.63,
                green: 0.69,
                blue: 0.72,
                alpha: 1.00)
        }
    }
    
    // MARK: Responders
    @IBAction func contactButtonWasPressed(sender: UIButton!) {
        if self.listing?.email != PFUser.currentUser()?.email {
            let subject = NSString(string: "Swolemates: \(self.listing!.title)").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let body = NSString(string: "Hey! I'd love to book some time in your home gym.\nWhen: ").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            
            let mailURL = NSURL(string: "mailto://\(self.listing!.email)?subject=\(subject)&body=\(body)")!
            UIApplication.sharedApplication().openURL(mailURL)
        } else { // Delete listing
            let alertController = UIAlertController(title: "You sure?",
                message: "If you delete this listing, it'll be gone. Poof.",
                preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Delete", style: .Destructive) { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewControllerAnimated(true)
                self.listing?.deleteInBackground()
            })
            
            self.presentViewController(alertController,
                animated: true,
                completion: nil)
        }
    }
}

extension ListingViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
