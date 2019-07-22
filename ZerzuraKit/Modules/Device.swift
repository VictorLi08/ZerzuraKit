//
//  System.swift
//  ZerzuraKit
//
//  Created by Victor Li on 5/13/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Foundation
import UIKit

/**
 A class that interacts with device settings and device properties.
 */
public class ZDevice {
    /// A path to the device's base document directory.
    public let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    /**
     Gets a locale based on the device's first preferred language.
     
     - Returns: A Locale() object.
     */
    public static func preferredLocale() -> Locale {
        guard let localeID = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: localeID)
    }
    
    /**
     Checks to see if the current device supports a certain version of iOS.
     
     ### Usage Example ###
     ```
     // assume that the device is running iOS 12.4

     override var preferredStatusBarStyle: UIStatusBarStyle {
         if !ZDevice.supports(iOS: 13.0) {
             return .lightContent       // status bar will be set automatically to white
         }
         return .default        // use whatever status bar the system is using
     }
     ```
     
     - Parameter iOS: A Double representing the iOS version that the check should be performed against.
     
     - Returns: True or False whether or not the device supports the iOS version specified.
     */
    public static func supports(iOS: Double) -> Bool {
        return iOS <= (Double(UIDevice.current.systemVersion) ?? 0.0)
    }
}
