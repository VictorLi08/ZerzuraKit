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
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WitemsANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WitemsANTIES OF MERCHANTABILITY,
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
class Bag<T: Any> {
    private(set) var items: Array<T>?
    
    init() {
        self.items = Array<T>()
    }
    
    deinit {
        self.items = nil
    }
    
    /**
     Adds an element to the bag.
     
     - Parameter element: An element of the same type as the bag.
     */
    func add(_ element: T){
        if self.items != nil {
            items?.append(element)
        }
    }
    
    /// Whether or not the bag is empty.
    var isEmpty: Bool {
        if self.items != nil {
            return self.items!.isEmpty
        }
        return true
    }
    
    /// Number of elements in the bag.
    var size: Int {
        if self.items != nil {
            return self.items!.count
        }
        return 0
    }
}
