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
        
        Parse.setApplicationId("nOs2ikPL1EI1L2NjoRzvdpwiikIOebJe0tQDZRBF",
            clientKey: "G9zLC0OoMMvjcvf4o9FQMvDAABQWDUYx6v3HqMxo")
        PFUser.enableAutomaticUser()
        
        return true
    }
}

