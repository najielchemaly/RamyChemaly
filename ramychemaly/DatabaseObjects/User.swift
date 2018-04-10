//
//  User.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class User: NSObject, NSCoding {
    public var id : String?
    public var fullname : String?
    public var email : String?
    public var phone : String?
    public var facebook_token : String?
    public var facebook_id : String?
    public var role : String?
    public var avatar: String?
    public var gender: String?
    public var avatar_name: String?
    
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
    
    required public override init() { }
    
    required public init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey:"id") as? String
        fullname = decoder.decodeObject(forKey:"fullname") as? String
        email = decoder.decodeObject(forKey:"email") as? String
        phone = decoder.decodeObject(forKey:"phone") as? String
        facebook_token = decoder.decodeObject(forKey:"facebook_token") as? String
        facebook_id = decoder.decodeObject(forKey:"facebook_id") as? String
        role = decoder.decodeObject(forKey:"role") as? String
        avatar = decoder.decodeObject(forKey:"avatar") as? String
        gender = decoder.decodeObject(forKey:"gender") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(fullname, forKey: "fullname")
        coder.encode(email, forKey: "email")
        coder.encode(phone, forKey: "phone")
        coder.encode(facebook_token, forKey: "facebook_token")
        coder.encode(facebook_id, forKey: "facebook_id")
        coder.encode(role, forKey: "role")
        coder.encode(avatar, forKey: "avatar")
        coder.encode(gender, forKey: "gender")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        fullname = dictionary["fullname"] as? String
        email = dictionary["email"] as? String
        phone = dictionary["phone"] as? String
        facebook_token = dictionary["facebook_token"] as? String
        facebook_id = dictionary["facebook_id"] as? String
        role = dictionary["role"] as? String
        avatar = dictionary["avatar"] as? String
        gender = dictionary["gender"] as? String
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
        dictionary.setValue(self.facebook_id, forKey: "facebook_id")
        dictionary.setValue(self.role, forKey: "role")
        dictionary.setValue(self.avatar, forKey: "avatar")
        dictionary.setValue(self.gender, forKey: "gender")
        
        return dictionary
    }
    
}
