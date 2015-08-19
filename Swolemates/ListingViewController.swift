//
//  ListingViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class ListingViewController: UITableViewController {
    // MARK: Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var listing: GymListing?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        self.navigationItem.title = self.listing?.title ?? "Listing"
        self.tableView.layoutMargins = UIEdgeInsets()
    }
}
