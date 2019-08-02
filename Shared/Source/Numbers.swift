//
//  Numbers.swift
//  ZerzuraKit
//
//  Created by Victor Li on 5/21/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Foundation

/**
 An object that contains methods for numbers.
 */
public class ZNum {
    /**
     An object that contains methods for binary numbers.
     */
    public class binary {
        /**
         Pads a String with leading zeroes up to the given length.

         ### Usage Example ###
         ````
         let c = ZNum.binary.pad(binaryString: "00001", length: 10)
         print(c)       // 0000000001
         ````
         
         - Parameter binaryString: A String representing a binary number.
         - Parameter desiredLength: The desired overall length of the result.
         
         - Returns: A binary string padded from the front to the desired length.
         */
        
        public static func pad(binaryString: String, desiredLength: Int) -> String {
            var newString = binaryString
 
            if desiredLength > binaryString.count {
                for _ in 0 ... desiredLength {
                    newString = "0" + newString
                }
            }
            return newString
        }
    }
}


