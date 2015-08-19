//
//  DiscoverViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import GradientView
import Parse

class DiscoverViewController: UITableViewController {
    // MARK: Properties
    private var listings: [GymListing] = []
    private var presentedFirstAbout: Bool = false
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layoutMargins = UIEdgeInsets()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "listingWasSaved:",
            name: GymListing.DidFinishSavingNotification,
            object: nil)
        
        self.refreshControl?.tintColor = UIColor.swoleLightColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.reloadData()
        
        if PFUser.currentUser()?.email == nil {
            if !self.presentedFirstAbout {
                self.performSegueWithIdentifier("PresentAbout", sender: nil)
                self.presentedFirstAbout = true
            } else {
                self.performSegueWithIdentifier("PresentLogin", sender: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("PushDetail"):
            let listing = sender as! GymListing
            
            let listingVC = segue.destinationViewController as! ListingViewController
            listingVC.listing = listing
            
        default:
            break
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: Data Handlers
    func reloadData() {
        GymListing.allFromServer { (listings: [GymListing]) in
            self.listings = listings.reverse()
            self.tableView.reloadData()
        }
    }
    
    // MARK: Repsponders
    func listingWasSaved(notification: NSNotification!) {
        self.reloadData()
    }
    
    @IBAction func refreshControlWasTrigger(sender: UIRefreshControl!) {
        self.reloadData()
        sender.endRefreshing()
    }
}

extension DiscoverViewController: UITableViewDataSource {
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GymListing") as! UITableViewCell
        let listing = self.listings[indexPath.row]
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.setImageWithURL(listing.photoURL)
        
        let titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = listing.title
        
        let priceLabel = cell.viewWithTag(4) as! UILabel
        priceLabel.text = "$\(listing.price)/hr"
        
        let topGradientView = cell.viewWithTag(5) as! GradientView
        topGradientView.colors = [
            UIColor(white: 0.0, alpha: 0.6),
            UIColor(white: 0.0, alpha: 0.0)
        ]
        
        let bottomGradientView = cell.viewWithTag(6) as! GradientView
        bottomGradientView.colors = [
            UIColor(white: 0.0, alpha: 0.0),
            UIColor(white: 0.0, alpha: 0.6)
        ]
        
        return cell
    }
}

extension DiscoverViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let listing = self.listings[indexPath.row]
        self.performSegueWithIdentifier("PushDetail", sender: listing)
    }
}
