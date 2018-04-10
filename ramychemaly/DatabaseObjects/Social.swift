//
//  Social.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Social: NSObject, NSCoding {
    public var id : String?
    public var img_thumb : String?
    public var title : String?
    public var link : String?
    public var image: UIImage?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Social]
    {
        var models:[Social] = []
        for item in array
        {
            models.append(Social(dictionary: item as! NSDictionary)!)
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
    
    public init(image: UIImage, title: String, link: String) {
        self.image = image
        self.title = title
        self.link = link
    }
    
    required public override init() { }
    
    required public init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey:"id") as? String
        img_thumb = decoder.decodeObject(forKey:"img_thumb") as? String
        title = decoder.decodeObject(forKey:"title") as? String
        link = decoder.decodeObject(forKey:"link") as? String
        image = decoder.decodeObject(forKey:"image") as? UIImage
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(img_thumb, forKey: "img_thumb")
        coder.encode(title, forKey: "title")
        coder.encode(link, forKey: "link")
        coder.encode(image, forKey: "image")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        img_thumb = dictionary["img_thumb"] as? String
        title = dictionary["title"] as? String
        link = dictionary["link"] as? String
        image = dictionary["image"] as? UIImage
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.img_thumb, forKey: "img_thumb")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.link, forKey: "link")
        dictionary.setValue(self.image, forKey: "image")
        
        return dictionary
    }
    
}

