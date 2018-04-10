//
//  PhotoGallery.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class MediaGallery: NSObject, NSCoding {
    public var id : String?
    public var title : String?
    public var img_thumb : String?
    public var photos : Array<Photo>?
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
    
    required public override init() { }
    
    required public init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey:"id") as? String
        title = decoder.decodeObject(forKey:"title") as? String
        img_thumb = decoder.decodeObject(forKey:"img_thumb") as? String
        photos = decoder.decodeObject(forKey:"photos") as? Array<Photo>
        videos = decoder.decodeObject(forKey:"videos") as? Array<Video>
        type = decoder.decodeObject(forKey:"type") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(img_thumb, forKey: "img_thumb")
        coder.encode(photos, forKey: "photos")
        coder.encode(videos, forKey: "videos")
        coder.encode(type, forKey: "type")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        title = dictionary["title"] as? String
        img_thumb = dictionary["img_thumb"] as? String
        type = dictionary["type"] as? String
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
