//
//  User.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class User {
    public var id : Int?
    public var fullname : String?
    public var email : String?
    public var phone : String?
    public var facebook_token : String?
    public var img_url : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Notifications = Notifications(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Notifications Instance.
     */
    
    required public init() {
        
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        fullname = dictionary["fullname"] as? String
        email = dictionary["email"] as? String
        phone = dictionary["phone"] as? String
        facebook_token = dictionary["facebook_token"] as? String
        img_url = dictionary["img_url"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.fullname, forKey: "fullname")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.facebook_token, forKey: "facebook_token")
        dictionary.setValue(self.img_url, forKey: "img_url")
        
        return dictionary
    }
    
}
