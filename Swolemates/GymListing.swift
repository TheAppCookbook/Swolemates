//
//  GymListing.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse
import CoreLocation
import AFNetworking

class GymListing: PFObject, PFSubclassing {
    // MARK: Constants
    static let DidFinishSavingNotification: String = "DidFinishSavingNotification"
    
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
    
    @NSManaged var parsePhotoURL: String
    var photoURL: NSURL? {
        get { return NSURL(string: self.parsePhotoURL ?? "") }
    }

    @NSManaged var parseEquipment: String
    var equipment: String {
        get { return self.parseEquipment }
    }
    
    @NSManaged var parsePrice: Int
    var price: USCents {
        return self.parsePrice
    }
    
    @NSManaged var parseAvailabilities: NSArray
    var availabilities: [NSDate: (NSDate, NSDate)] {
        get {
            var availabilities: [NSDate: (NSDate, NSDate)] = [:]
            for cluster in self.parseAvailabilities {
                availabilities[cluster[0] as! NSDate] = (cluster[1][0] as! NSDate, cluster[1][1] as! NSDate)
            }
            
            return availabilities
        }
        
        set {
            var availabilities = NSMutableArray()
            for (date, times) in newValue {
                availabilities.addObject([date, [times.0, times.1]])
            }
            
            self.parseAvailabilities = availabilities
        }
    }
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    init(title: String, streetAddress: String, zipCode: String, price: USCents, equipment: String) {
        super.init()
        
        self.parseTitle = title
        self.parseLocation = ["street": streetAddress, "zip": zipCode]
        self.parseEquipment = equipment
        self.parsePrice = price
        self.parseAvailabilities = NSArray()
    }
    
    // MARK: Class Initializers
    override class func initialize() {
        super.initialize()
        self.registerSubclass()
    }
    
    // MARK: Class Accessors
    class func allFromServer(completion: ([GymListing]) -> Void) {
        let query = PFQuery(className: self.parseClassName())
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) in
            completion(objects as! [GymListing])
        }
    }
    
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
    
    // MARK: Mutators
    func setPhoto(photo: UIImage, completion: (NSURL?) -> Void) {
        if let photoData = UIImagePNGRepresentation(photo) {
            let encodedData = photoData.base64EncodedStringWithOptions(nil)
            
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFJSONResponseSerializer()
            manager.requestSerializer.setValue("Client-ID 5c4f0c2de0df9d3", forHTTPHeaderField: "Authorization")
            
            manager.POST("https://api.imgur.com/3/image", parameters: ["image": encodedData], success: { (op: AFHTTPRequestOperation!, response: AnyObject!) in
                self.parsePhotoURL = (response["data"] as! NSDictionary)["link"] as! String
                completion(self.photoURL)
            }, failure: { (op: AFHTTPRequestOperation!, error: NSError!) in
                completion(nil)
            })
        }
    }
    
    func saveAndNotify() -> Void {
        self.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            NSNotificationCenter.defaultCenter().postNotificationName(GymListing.DidFinishSavingNotification,
                object: self,
                userInfo: ["error": error ?? NSNull()] as [NSObject : AnyObject])
        }
    }
}
