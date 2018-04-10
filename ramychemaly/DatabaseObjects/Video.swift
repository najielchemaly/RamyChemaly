//
//  Video.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Video: NSObject, NSCoding {
    public var id : String?
    public var img_thumb : String?
    public var link : String?
    public var title : String?
    public var media_id : String?
    public var duration : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Video]
    {
        var models:[Video] = []
        for item in array
        {
            models.append(Video(dictionary: item as! NSDictionary)!)
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
    
    public init(imgThumb: String, link: String, duration: String, media_id: String, title: String) {
        self.img_thumb = imgThumb
        self.link = link
        self.duration = duration
        self.media_id = media_id
        self.title = title
    }
    
    required public override init() { }
    
    required public init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey:"id") as? String
        img_thumb = decoder.decodeObject(forKey:"img_thumb") as? String
        link = decoder.decodeObject(forKey:"link") as? String
        duration = decoder.decodeObject(forKey:"duration") as? String
        title = decoder.decodeObject(forKey:"title") as? String
        media_id = decoder.decodeObject(forKey:"media_id") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(img_thumb, forKey: "img_thumb")
        coder.encode(link, forKey: "link")
        coder.encode(duration, forKey: "duration")
        coder.encode(title, forKey: "title")
        coder.encode(media_id, forKey: "media_id")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        img_thumb = dictionary["img_thumb"] as? String
        link = dictionary["link"] as? String
        title = dictionary["title"] as? String
        media_id = dictionary["media_id"] as? String
        duration = dictionary["duration"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.img_thumb, forKey: "img_thumb")
        dictionary.setValue(self.link, forKey: "link")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.media_id, forKey: "media_id")
        dictionary.setValue(self.duration, forKey: "duration")
        
        return dictionary
    }
    
}
