//
//  BreadOfLife.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class BreadOfLife: NSObject, NSCoding {
    public var id : String?
    public var title : String?
    public var desc : String?
    public var img_url : String?
    public var video_url : String?
    public var date : String?
    public var type : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [BreadOfLife]
    {
        var models:[BreadOfLife] = []
        for item in array
        {
            models.append(BreadOfLife(dictionary: item as! NSDictionary)!)
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
    
    public init(title: String, desc: String, date: String) {
        self.title = title
        self.desc = desc
        self.date = date
    }
    
    required public override init() { }
    
    required public init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey:"id") as? String
        title = decoder.decodeObject(forKey:"title") as? String
        desc = decoder.decodeObject(forKey:"description") as? String
        img_url = decoder.decodeObject(forKey:"img_url") as? String
        video_url = decoder.decodeObject(forKey:"video_url") as? String
        date = decoder.decodeObject(forKey:"date") as? String
        type = decoder.decodeObject(forKey:"type") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(desc, forKey: "description")
        coder.encode(img_url, forKey: "img_url")
        coder.encode(video_url, forKey: "video_url")
        coder.encode(date, forKey: "date")
        coder.encode(type, forKey: "type")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        title = dictionary["title"] as? String
        desc = dictionary["description"] as? String
        img_url = dictionary["img_url"] as? String
        video_url = dictionary["video_url"] as? String
        date = dictionary["date"] as? String
        type = dictionary["type"] as? String
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
        dictionary.setValue(self.img_url, forKey: "img_url")
        dictionary.setValue(self.video_url, forKey: "video_url")
        dictionary.setValue(self.date, forKey: "date")
        dictionary.setValue(self.type, forKey: "type")
        
        return dictionary
    }
    
}
