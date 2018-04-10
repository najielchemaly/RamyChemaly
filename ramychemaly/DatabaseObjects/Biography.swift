//
//  Biography.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Biography: NSObject, NSCoding {
    public var id : String?
    public var title_short : String?
    public var title_long : String?
    public var img_thumb : String?
    public var img_url : String?
    public var desc : String?
    
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
    
    required public override init() { }
    
    required public init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey:"id") as? String
        title_short = decoder.decodeObject(forKey:"title_short") as? String
        title_long = decoder.decodeObject(forKey:"title_long") as? String
        img_thumb = decoder.decodeObject(forKey:"img_thumb") as? String
        img_url = decoder.decodeObject(forKey:"img_url") as? String
        desc = decoder.decodeObject(forKey:"description") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title_short, forKey: "title_short")
        coder.encode(title_long, forKey: "title_long")
        coder.encode(img_thumb, forKey: "img_thumb")
        coder.encode(img_url, forKey: "img_url")
        coder.encode(desc, forKey: "description")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        title_short = dictionary["title_short"] as? String
        title_long = dictionary["title_long"] as? String
        desc = dictionary["description"] as? String
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
        dictionary.setValue(self.desc, forKey: "description")
        dictionary.setValue(self.img_thumb, forKey: "img_thumb")
        dictionary.setValue(self.img_url, forKey: "img_url")
        
        return dictionary
    }
    
}
