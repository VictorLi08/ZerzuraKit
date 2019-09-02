//
//  Logic.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/9/2.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

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
    
    func &(lhs: Array, rhs: Array) -> Array {
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
    
    func -(lhs: Array, rhs: Array) -> Array {
        return lhs.diff(rhs)
    }
}
