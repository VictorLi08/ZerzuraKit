//
//  Numbers.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/8/16.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

extension Int {
    /// Pre-increments an integer and returns its incremented value.
    @discardableResult
    static prefix func ++(lhs: inout Int) -> Int {
        lhs += 1
        return lhs
    }
    
    /// Post-increments an integer and returns its previous value.
    @discardableResult
    static postfix func ++(lhs: inout Int) -> Int {
        lhs += 1
        return lhs - 1
    }
    
    /// Pre-decrements an integer and returns its decremented value.
    @discardableResult
    static prefix func --(lhs: inout Int) -> Int {
        lhs -= 1
        return lhs
    }
    
    /// Post-decrements an integer and returns its previous value.
    @discardableResult
    static postfix func --(lhs: inout Int) -> Int {
        lhs -= 1
        return lhs + 1
    }
    
    /**
     Generates a string representing the Int in binary.
     
     - Parameter len: The length of the desired string (bin will pad zeroes to the desired length). If none is provided, a minimum length is returned.
     
     - Returns: A binary string representing the Int.
     */
    func bin(len: Int? = 0) -> String {
        var binStr = String(self.advanced(by: 0), radix: 2)
        if let strLen = len, binStr.count < strLen {
            for _ in 1 ... (strLen - binStr.count) {
                binStr = "0" + binStr
            }
        }
        return binStr
    }
    
    /**
    Generates a string representing the Int in hexidecimal.
    
    - Parameter len: The length of the desired string (hex will pad zeroes to the desired length). If none is provided, a minimum length is returned.
    
    - Returns: A hex string representing the Int.
    */
    func hex(len: Int? = 0) -> String {
        var binStr = String(self.advanced(by: 0), radix: 2)
        if let strLen = len, binStr.count < strLen {
            for _ in 1 ... (strLen - binStr.count) {
                binStr = "0" + binStr
            }
        }
        return binStr
    }
}

extension Double {
    @discardableResult
    static func %(lhs: Double, rhs: Double) -> Double {
        return lhs.truncatingRemainder(dividingBy: rhs)
    }
}
