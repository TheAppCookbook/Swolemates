//
//  PostViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class PostViewController: UITableViewController {
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.layoutMargins = UIEdgeInsets()
        self.tableView.separatorInset = UIEdgeInsets()
    }
}

extension PostViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsets()
        cell.layoutMargins = UIEdgeInsets()
    }
}