//
//  Audio.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/11/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import UIKit

public class Audio: NSObject, NSCoding {
    public var id : String?
    public var audio_url : String?
    public var media_id : String?
    public var duration : String?
    public var artist_name : String?
    public var album_name : String?
    public var song_name : String?
    public var album_artwork : String?
    public var audio_path : URL?

    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Notifications_list = Notifications.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notifications Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Audio]
    {
        var models:[Audio] = []
        for item in array
        {
            models.append(Audio(dictionary: item as! NSDictionary)!)
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
    
    public init(artist_name: String, album_name: String, song_name: String, album_artwork: String, audio_url: String) {
        self.artist_name = artist_name
        self.album_name = album_name
        self.song_name = song_name
        self.album_artwork = album_artwork
        self.audio_url = audio_url
    }
    
    required public override init() { }
    
    required public init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey:"id") as? String
        audio_url = decoder.decodeObject(forKey:"audio_url") as? String
        media_id = decoder.decodeObject(forKey:"media_id") as? String
        duration = decoder.decodeObject(forKey:"duration") as? String
        artist_name = decoder.decodeObject(forKey:"artist_name") as? String
        album_name = decoder.decodeObject(forKey:"album_name") as? String
        song_name = decoder.decodeObject(forKey:"song_name") as? String
        album_artwork = decoder.decodeObject(forKey:"album_artwork") as? String
        audio_path = decoder.decodeObject(forKey:"audio_path") as? URL
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(audio_url, forKey: "audio_url")
        coder.encode(media_id, forKey: "media_id")
        coder.encode(duration, forKey: "duration")
        coder.encode(artist_name, forKey: "artist_name")
        coder.encode(album_name, forKey: "album_name")
        coder.encode(song_name, forKey: "song_name")
        coder.encode(album_artwork, forKey: "album_artwork")
        coder.encode(audio_path, forKey: "audio_path")
    }
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        audio_url = dictionary["audio_url"] as? String
        media_id = dictionary["media_id"] as? String
        duration = dictionary["duration"] as? String
        artist_name = dictionary["artist_name"] as? String
        album_name = dictionary["album_name"] as? String
        song_name = dictionary["song_name"] as? String
        album_artwork = dictionary["album_artwork"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.audio_url, forKey: "audio_url")
        dictionary.setValue(self.media_id, forKey: "media_id")
        dictionary.setValue(self.duration, forKey: "duration")
        dictionary.setValue(self.artist_name, forKey: "artist_name")
        dictionary.setValue(self.album_name, forKey: "album_name")
        dictionary.setValue(self.song_name, forKey: "song_name")
        dictionary.setValue(self.album_artwork, forKey: "album_artwork")
        
        return dictionary
    }
    
}
