//
//  AppDelegate.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Class Accessors
    class var sharedAppDelegate: AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    // MARK: Properties
    var window: UIWindow?
    
    // MARK: Lifecycle
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        // Parse
        Parse.setApplicationId("nOs2ikPL1EI1L2NjoRzvdpwiikIOebJe0tQDZRBF",
            clientKey: "G9zLC0OoMMvjcvf4o9FQMvDAABQWDUYx6v3HqMxo")
        PFUser.enableAutomaticUser()
        
        // Appearance
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "OpenSans-Semibold", size: 15.0)!
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "OpenSans-Semibold", size: 15.0)!
        ], forState: .Normal)
        
        UILabel.appearanceWhenContainedInClass(UITableViewHeaderFooterView).font = UIFont(name: "OpenSans-Semibold", size: 15.0)!
        UILabel.appearanceWhenContainedInClass(UITableViewHeaderFooterView).textColor = UIColor(red: 0.63,
            green: 0.69,
            blue: 0.73,
            alpha: 1.00)
        
        return true
    }
}
