//
//  DiscoverViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import GradientView

class DiscoverViewController: UITableViewController {
    // MARK: Lifecycle
    override func viewDidLoad() {
        self.tableView.layoutMargins = UIEdgeInsets()
        self.tableView.reloadData()
    }
}

extension DiscoverViewController: UITableViewDataSource {
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GymListing") as! UITableViewCell
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: "TestImage")
        
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
