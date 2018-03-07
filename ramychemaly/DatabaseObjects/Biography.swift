//
//  Biography.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Biography {
    public var id : Int?
    public var title_short : String?
    public var title_long : String?
    public var img_thumb : String?
    public var img_url : String?
    public var description : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Biography]
    {
        var models:[Biography] = []
        for item in array
        {
            models.append(Biography(dictionary: item as! NSDictionary)!)
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
        title_short = dictionary["title_short"] as? String
        title_long = dictionary["title_long"] as? String
        description = dictionary["description"] as? String
        img_thumb = dictionary["img_thumb"] as? String
        img_url = dictionary["img_url"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.title_short, forKey: "title_short")
        dictionary.setValue(self.title_long, forKey: "title_long")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.img_thumb, forKey: "img_thumb")
        dictionary.setValue(self.img_url, forKey: "img_url")
        
        return dictionary
    }
    
}
