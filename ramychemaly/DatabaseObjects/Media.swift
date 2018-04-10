//
//  Media.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/15/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

public class Media: NSObject, NSCoding {
    public var mediaGallery : Array<MediaGallery>?
    public var audios : Array<Audio>?
    public var socials : Array<Social>?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Media]
    {
        var models:[Media] = []
        for item in array
        {
            models.append(Media(dictionary: item as! NSDictionary)!)
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
        mediaGallery = decoder.decodeObject(forKey:"mediaGallery") as? Array<MediaGallery>
        audios = decoder.decodeObject(forKey:"audios") as? Array<Audio>
        socials = decoder.decodeObject(forKey:"socials") as? Array<Social>
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(mediaGallery, forKey: "mediaGallery")
        coder.encode(audios, forKey: "audios")
        coder.encode(socials, forKey: "socials")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["mediaGallery"] != nil) {
            mediaGallery = MediaGallery.modelsFromDictionaryArray(array: dictionary["mediaGallery"] as! NSArray)
        }
        if (dictionary["audios"] != nil) {
            audios = Audio.modelsFromDictionaryArray(array: dictionary["audios"] as! NSArray)
        }
        if (dictionary["socials"] != nil) {
            socials = Social.modelsFromDictionaryArray(array: dictionary["socials"] as! NSArray)
        }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        return dictionary
    }
    
}
