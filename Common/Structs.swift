//
//    Structs.swift
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

/**
 Generic bag data structure.
 
 # Usage #
 ````
 let b = Bag<String>()
 ````
 */
class Bag<T: Equatable> {
    internal var arr = Array<T>()
    
    init() {
        
    }
    
    /**
     Adds an element to the bag.
     
     - Parameter element: An element of the same type as the bag.
     */
    func add(_ element: T){
        arr.append(element)
    }
    
    /**
     Removes an element from the bag.
     
     - Returns: A random element from the bag.
     */
    func remove() -> T {
        let chosen = Int.random(in: 0 ... (arr.count - 1))
        return arr.remove(at: chosen)
    }
    
    /**
     Determines whether or not a bag is less than or equal to another bag.
     
     # Usage #
     ````
     let lte = A <= B
     ````
     
     - Returns: True or False if the left-hand side is a subset of the right-hand side.
     */
    static func <=(lhs: Bag, rhs: Bag) -> Bool {
        return lhs.arr.isSubset(rhs.arr)
    }
}
