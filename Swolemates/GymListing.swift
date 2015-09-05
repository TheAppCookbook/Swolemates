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
    
    @NSManaged var parsePrice: Int
    var price: Int {
        return self.parsePrice
    }
    
    @NSManaged var parseEmail: String
    var email: String {
        return self.parseEmail
    }
    
    var username: String {
        return self.parseEmail.componentsSeparatedByString("@")[0]
    }
    
    @NSManaged var parsePhotoURL: String
    var photoURL: NSURL? {
        get { return NSURL(string: self.parsePhotoURL ?? "") }
    }

    @NSManaged var parseDescription: String
    var listingDescription: String {
        get { return self.parseDescription }
    }
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    init(title: String, description: String, price: Int) {
        super.init()
        
        self.parseTitle = title
        self.parseDescription = description
        self.parsePrice = price
        self.parseEmail = PFUser.currentUser()!.email!
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
    
    // MARK: Mutators
    func setPhoto(photo: UIImage, completion: (NSURL?) -> Void) {
        if let photoData = UIImagePNGRepresentation(photo) {
            let encodedData = photoData.base64EncodedStringWithOptions([])
            
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
