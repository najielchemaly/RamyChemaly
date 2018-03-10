//
//  Video.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Video {
    public var id : Int?
    public var img_thumb : String?
    public var link : String?
    public var title : String?
    public var gallery : String?
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
    
    public init(imgThumb: String, link: String, duration: String, gallery: String, title: String) {
        self.img_thumb = imgThumb
        self.link = link
        self.duration = duration
        self.gallery = gallery
        self.title = title
    }
    
    required public init() {
        
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        img_thumb = dictionary["img_thumb"] as? String
        link = dictionary["link"] as? String
        title = dictionary["title"] as? String
        gallery = dictionary["gallery"] as? String
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
        dictionary.setValue(self.gallery, forKey: "gallery")
        dictionary.setValue(self.duration, forKey: "duration")
        
        return dictionary
    }
    
}
