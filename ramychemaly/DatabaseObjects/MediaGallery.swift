//
//  PhotoGallery.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class MediaGallery {
    public var id : Int?
    public var title : String?
    public var img_thumb : String?
    public var photos : [Photo]?
    public var videos : Array<Video>? 
    public var type : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [MediaGallery]
    {
        var models:[MediaGallery] = []
        for item in array
        {
            models.append(MediaGallery(dictionary: item as! NSDictionary)!)
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
        title = dictionary["title"] as? String
        img_thumb = dictionary["img_thumb"] as? String
        if (dictionary["photos"] != nil) {
            photos = Photo.modelsFromDictionaryArray(array: dictionary["photos"] as! NSArray)
        }
        if (dictionary["videos"] != nil) {
            videos = Video.modelsFromDictionaryArray(array: dictionary["videos"] as! NSArray)
        }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.img_thumb, forKey: "img_thumb")
        
        return dictionary
    }
    
}
