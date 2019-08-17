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
extension ZDevice {
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
    static func supports(iOS: CGFloat) -> Bool {
        return Double(iOS) <= (Double(UIDevice.current.systemVersion) ?? 0.0)
    }
}
