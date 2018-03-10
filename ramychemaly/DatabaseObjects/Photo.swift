//
//  Photo.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Photo {
    public var id : Int?
    public var img_thumb : String?
    public var img_url : String?
    public var gallery : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Photo]
    {
        var models:[Photo] = []
        for item in array
        {
            models.append(Photo(dictionary: item as! NSDictionary)!)
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
    
    public init(imgThumb: String, gallery: String) {
        self.img_thumb = imgThumb
        self.gallery = gallery
    }
    
    required public init() {
        
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        img_thumb = dictionary["img_thumb"] as? String
        img_url = dictionary["img_url"] as? String
        gallery = dictionary["gallery"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.img_thumb, forKey: "img_thumb")
        dictionary.setValue(self.img_url, forKey: "img_url")
        dictionary.setValue(self.gallery, forKey: "gallery")
        
        return dictionary
    }
    
}

