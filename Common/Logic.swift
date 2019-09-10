//
//    Logic.swift
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

extension Array where Element: Equatable {
    /**
     Determines whether or not this array is a subset of another.
     
     # Usage #
     Write statements using this method in this manner: is [array] a subset of [array]? For example, A.isSubset(B) is read as "is A a subset of B?".
     
     ````
     let A = ["hello"]
     let B = ["hello", "there"]
     
     let s = A.isSubset(B)      // true
     ````
     - Parameter compare: Array to compare to.
     
     - Returns: True or False if the instance array is a subset of the compare array.
     */
    func isSubset(_ compare: Array) -> Bool {
        for item in self {
            if !compare.contains(item) {
                return false
            }
        }
        return true
    }
    
    /**
     Produces the intersection of this array and another.
     
     # Usage #
     ````
     let A = ["hello"]
     let B = ["hello", "there"]
     
     let i = A.intersect(B)     // ["hello"]
     
     let i = A & B              // ["hello"], alternative syntax
     ````
     
     - Parameter compare: Array to compare to.
     
     - Returns: An array containing the common elements of both arrays.
     */
    func intersect(_ compare: Array) -> Array {
        var common = Array<Element>()
        for item in self {
            if compare.contains(item) {
                common.append(item)
            }
        }
        return common
    }
    
    static func &(lhs: Array, rhs: Array) -> Array {
        return lhs.intersect(rhs)
    }
    
    /**
     Produces the difference of this array and another.
     
     # Usage #
     ````
     let A = ["hello"]
     let B = ["hello", "there"]
     
     let i = A.diff(B)      // empty array
     let j = B.diff(A)      // ["there"]
     
     let j = B - A          // ["there"], alternative syntax
     ````
     
     - Parameter compare: Array to compare to.
     
     - Returns: An array containing elements of this array that are not in the other.
     */
    func diff(_ compare: Array) -> Array {
        var difference = Array<Element>()
        for item in self {
            if !compare.contains(item) {
                difference.append(item)
            }
        }
        return difference
    }
    
    static func -(lhs: Array, rhs: Array) -> Array {
        return lhs.diff(rhs)
    }
    
    static func ==(lhs: Array, rhs: Array) -> Bool {
        if lhs.count != rhs.count {
            return false
        }
        
        for item in lhs {
            if !rhs.contains(item) {
                return false
            }
        }
        
        return true
    }
    
    static func !=(lhs: Array, rhs: Array) -> Bool {
        if lhs.count != rhs.count {
            return true
        }
        
        let adjustedLength = lhs.count - 1
        for index in 0 ... adjustedLength {
            if lhs[index] != rhs[index] {
                return true
            }
        }
        
        return false
    }
    
    static func &=(lhs: Array, rhs: Array) -> Bool {
        if lhs.count != rhs.count {
            return false
        }
        
        let adjustedLength = lhs.count - 1
        for index in 0 ... adjustedLength {
            if lhs[index] != rhs[index] {
                return false
            }
        }
        
        return true
    }
}
