//
//    Numbers.swift
//    ZerzuraKit
//
//    Copyright (c) 2019 Victor Li
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

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
