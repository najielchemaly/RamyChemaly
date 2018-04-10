//
//  Notification.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/6/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Notification: NSObject, NSCoding {
    public var id : String?
    public var title : String?
    public var desc : String?
    public var date : String?
    public var rowHeight: CGFloat?
    public var isRead: Bool?
    public var type: String?
    public var location: String?
    public var img_url: String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Notification]
    {
        var models:[Notification] = []
        for item in array
        {
            models.append(Notification(dictionary: item as! NSDictionary)!)
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
        title = decoder.decodeObject(forKey:"title") as? String
        desc = decoder.decodeObject(forKey:"description") as? String
        date = decoder.decodeObject(forKey:"date") as? String
        rowHeight = decoder.decodeObject(forKey:"rowHeight") as? CGFloat
        isRead = decoder.decodeObject(forKey:"isRead") as? Bool
        type = decoder.decodeObject(forKey:"type") as? String
        location = decoder.decodeObject(forKey:"location") as? String
        img_url = decoder.decodeObject(forKey:"img_url") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(desc, forKey: "description")
        coder.encode(date, forKey: "date")
        coder.encode(rowHeight, forKey: "rowHeight")
        coder.encode(isRead, forKey: "isRead")
        coder.encode(type, forKey: "type")
        coder.encode(location, forKey: "location")
        coder.encode(img_url, forKey: "img_url")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        title = dictionary["title"] as? String
        desc = dictionary["description"] as? String
        date = dictionary["date"] as? String
        isRead = dictionary["isRead"] as? Bool
        type = dictionary["type"] as? String
        location = dictionary["location"] as? String
        img_url = dictionary["img_url"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.desc, forKey: "description")
        dictionary.setValue(self.date, forKey: "date")
        dictionary.setValue(self.isRead, forKey: "isRead")
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.location, forKey: "location")
        dictionary.setValue(self.img_url, forKey: "img_url")
        
        return dictionary
    }
    
}
