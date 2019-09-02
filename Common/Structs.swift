//
//  Structs.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/9/2.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

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
    func <=(lhs: Bag, rhs: Bag) -> Bool {
        return lhs.arr.isSubset(rhs.arr)
    }
}
