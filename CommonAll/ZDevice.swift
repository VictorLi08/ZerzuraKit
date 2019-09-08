//
//  System.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/8/2.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

/**
 A class that interacts with device settings and device properties.
 */
class ZDevice {
    /**
     Produces a locale based on the device's most preferred language.
     
     - Returns: A Locale() object.
     */
    static func preferredLocale() -> Locale {
        guard let localeID = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: localeID)
    }
}

