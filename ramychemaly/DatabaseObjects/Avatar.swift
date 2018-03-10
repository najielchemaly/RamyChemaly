//
//  Avatar.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Avatar {
    public var id : Int?
    public var is_selected : Bool?
    public var img_url : String?
    public var image : UIImage?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Avatar]
    {
        var models:[Avatar] = []
        for item in array
        {
            models.append(Avatar(dictionary: item as! NSDictionary)!)
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
    
    public init(isSelected: Bool = false, image: UIImage) {
        self.is_selected = isSelected
        self.image = image
    }
    
    required public init() {
        
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        is_selected = dictionary["is_selected"] as? Bool
        img_url = dictionary["img_url"] as? String
        image = dictionary["image"] as? UIImage
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.is_selected, forKey: "is_selected")
        dictionary.setValue(self.img_url, forKey: "img_url")
        dictionary.setValue(self.image, forKey: "image")
        
        return dictionary
    }
    
}
