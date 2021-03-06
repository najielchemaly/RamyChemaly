//
//  AppDefaults.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/4/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

var currentVC: UIViewController!
var isUserLoggedIn: Bool = false
var isReview: Bool = false

let GMS_APIKEY = ""
let APPLE_LANGUAGE_KEY = "AppleLanguages"
let DEVICE_LANGUAGE_KEY = "AppleLocale"

var appDelegate: AppDelegate {
    get {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate
        }
        
        return AppDelegate()
    }
}

struct Colors {
    
    static let appBlue: UIColor = UIColor(hexString: "#278eb6")!
    static let appRed: UIColor = UIColor(hexString: "#e65e14")!
    static let textDark: UIColor = UIColor(hexString: "#192226")!
    static let textLight: UIColor = UIColor(hexString: "#373f43")!
    static let textXLight: UIColor = UIColor(hexString: "#8d969a")!
    static let lightGray: UIColor = UIColor(hexString: "#e3e7e9")!
    static let white: UIColor = UIColor(hexString: "#ffffff")!
    static let darkBlue: UIColor = UIColor(hexString: "#062d72")!
    static let lightBlue: UIColor = UIColor(hexString: "#6fd1ef")!
    
}

struct Fonts {
    
    static let names: [String?] = UIFont.fontNames(forFamilyName: "Montserrat")
    
    static var textFont_Regular: UIFont {
        get {
            if let fontName = Fonts.names[0] {
                return UIFont.init(name: fontName, size: 16)!
            }
            
            return UIFont.init()
        }
    }
    
    static var textFont_Medium: UIFont {
        get {
            if let fontName = Fonts.names[1] {
                return UIFont.init(name: fontName, size: 16)!
            }
            
            return UIFont.init()
        }
    }
    
    static var textFont_Bold: UIFont {
        get {
            if let fontName = Fonts.names[2] {
                return UIFont.init(name: fontName, size: 16)!
            }
            
            return UIFont.init()
        }
    }
    
    static var textFont_Light: UIFont {
        get {
            if let fontName = Fonts.names[3] {
                return UIFont.init(name: fontName, size: 16)!
            }
            
            return UIFont.init()
        }
    }
    
}

struct StoryboardIds {
    
    static let SelectLanguageViewController: String = "SelectLanguageViewController"
    static let SignupViewController: String = "SignupViewController"
    static let NewsViewController: String = "NewsViewController"
    static let NewsDetailsViewController: String = "NewsDetailsViewController"
    static let NotificationsViewController: String = "NotificationsViewController"
    static let ContactUsViewController: String = "ContactUsViewController"
    static let AboutViewController: String = "AboutViewController"
    static let ProfileViewController: String = "ProfileViewController"
    static let EditProfileViewController: String = "EditProfileViewController"
    static let LoginViewController: String = "LoginViewController"
    static let ForgotPasswordViewController: String = "ForgotPasswordViewController"
    static let LoadingViewController: String = "LoadingViewController"
    static let HomeViewController: String = "HomeViewController"
    static let HomeNavigationController: String = "HomeNavigationController"
    static let LoginNavigationController: String = "LoginNavigationController"
    static let WebViewController: String = "WebViewController"
    static let InitialMenuViewController: String = "InitialMenuViewController"
    
}

enum Keys: String {
    
    case AccessToken = "TOKEN"
    case AppLanguage = "APP-LANGUAGE"
    case AppVersion = "APP-VERSION"
    case DeviceId = "ID"
    
}

enum SegueId: String {
    
    case None
    
    var identifier: String {
        return String(describing: self).lowercased()
    }
    
}

enum Language: Int {
    
    case Arabic = 1
    case English = 2
    
}

enum NewsType {
    
    case None
    
    var identifier: String {
        return String(describing: self).lowercased()
    }
    
}

func getYears() -> NSMutableArray {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    let strDate = formatter.string(from: Date.init())
    if let intDate = Int(strDate) {
        let yearsArray: NSMutableArray = NSMutableArray()
        for i in (1964...intDate).reversed() {
            yearsArray.add(String(format: "%d", i))
        }
        
        return yearsArray
    }
    
    return NSMutableArray()
}
