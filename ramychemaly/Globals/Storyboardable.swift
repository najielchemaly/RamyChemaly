//
//  Storyboardable.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

protocol Storyboardable: class {
    static var defaultStoryboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var defaultStoryboardName: String {
        return String(describing: self)
    }
    
    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return vc
    }
    
    static func storyboardNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        
        guard let nc = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return nc
    }
    
    static func storyboardTabBarController() -> UITabBarController {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        
        guard let tc = storyboard.instantiateInitialViewController() as? UITabBarController else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return tc
    }
}


