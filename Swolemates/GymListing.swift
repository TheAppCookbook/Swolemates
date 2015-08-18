//
//  GymListing.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse
import CoreLocation

class GymListing: PFObject, PFSubclassing {
    // MARK: Properties
    @NSManaged var parseTitle: String
    var title: String {
        return self.parseTitle
    }
    
    @NSManaged var parseLocation: NSDictionary
    var streetAddress: String {
        return self.parseLocation["street"] as! String
    }
    
    var zipCode: String {
        return self.parseLocation["zip"] as! String
    }
    
    @NSManaged var parsePicture: NSData
    var picture: UIImage? {
        return UIImage(data: self.parsePicture)
    }
    
    @NSManaged var parseEquipment: NSArray
    var equipment: [String] {
        get { return self.parseEquipment as! [String] }
        set { self.parseEquipment = NSArray(array: newValue) }
    }
    
    @NSManaged var parsePrice: Int
    var price: USCents {
        return self.parsePrice
    }
    
    // MARK: Initializers
    required init(title: String, streetAddress: String, zipCode: String, price: USCents, picture: UIImage) {
        super.init()
        
        self.parseTitle = title
        self.parseLocation = ["street": streetAddress, "zip": zipCode]
        self.parsePicture = UIImagePNGRepresentation(picture) ?? NSData()
        self.parseEquipment = NSArray()
        self.parsePrice = price
    }
    
    // MARK: Class Initializers
    override class func initialize() {
        super.initialize()
        self.registerSubclass()
    }
    
    // MARK: Class Accessors
    class func parseClassName() -> String {
        return "GymListing"
    }
    
    // MARK: Accessors
    func location(handler: (CLLocation?) -> Void) {
        CLGeocoder().geocodeAddressString("\(self.streetAddress) \(self.zipCode)") { (results: [AnyObject]!, error: NSError!) in
            if let placemark = results.first as? CLPlacemark {
                handler(placemark.location)
            } else {
                handler(nil)
            }
        }
    }
}
