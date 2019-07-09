//
//  System.swift
//  ZerzuraKit
//
//  Created by Victor Li on 5/13/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Foundation

/**
 A class that interacts with device settings and device properties.
 */
public class ZSystem {
    /// A path to the device's base document directory.
    public let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    /**
     Determines the current system locale based on the device's preferred languages.
     
     - Returns: A Locale() object containing the preferred locale.
     */
    public static func locale() -> Locale {
        guard let localeID = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: localeID)
    }
}
