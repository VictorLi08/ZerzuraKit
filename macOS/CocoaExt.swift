//
//    Views.swift
//    ZerzuraKit-macOS
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

import Cocoa

public extension NSWindow {
    var isResizable: Bool {
        get {
            return self.styleMask.contains(.resizable)
        }
        set {
            if newValue == true {
                if !self.styleMask.contains(.resizable) {
                    self.styleMask.update(with: .resizable)
                }
            } else if newValue == false {
                self.styleMask.remove(.resizable)
            }
        }
    }
}

public extension NSView {
//    func fadeIn(duration: TimeInterval) {
//        NSView.animate(withDuration: duration, animations: {
//            self.alpha = 1.0
//        })
//    }
//
//    func fadeOut(duration: TimeInterval) {
//        NSView.animate(withDuration: duration, animations: {
//            self.alpha = 0.0
//        })
//    }
//
//    func flash(cycles: Int) {
//        if self.alphaValue < 1.0 {
//            for _ in 1 ... cycles {
//                self.fadeIn(duration: 0.1)
//                self.fadeOut(duration: 0.1)
//            }
//        } else {
//            for _ in 1 ... cycles {
//                self.fadeOut(duration: 0.1)
//                self.fadeIn(duration: 0.1)
//            }
//        }
//    }
    
    /// The position of the view's upper left-hand corner.
    var topLeftCorner: NSPoint {
        let positionX = self.frame.origin.x - (self.frame.width/2.0)
        let positionY = self.frame.origin.y - (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    /// The position of the view's upper right-hand corner.
    var topRightCorner: NSPoint {
        let positionX = self.frame.origin.x + (self.frame.width/2.0)
        let positionY = self.frame.origin.y - (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    /// The position of the view's lower left-hand corner.
    var bottomLeftCorner: NSPoint {
        let positionX = self.frame.origin.x - (self.frame.width/2.0)
        let positionY = self.frame.origin.y + (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    /// The position of the view's lower right-hand corner.
    var bottomRightCorner: NSPoint {
        let positionX = self.frame.origin.x + (self.frame.width/2.0)
        let positionY = self.frame.origin.y + (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    /// The position of the view's center.
    var center: NSPoint {
        let positionX = self.frame.origin.x
        let positionY = self.frame.origin.y
        return NSPoint(x: positionX, y: positionY)
    }
}

public extension NSScrollView {
    /// Scrolls the view to its topmost position.
    func top() {
        self.scroll(CGPoint(x: self.contentInsets.left, y: self.contentInsets.top))
    }
    
    /// Scrolls the view to its lowest position.
    func bottom() {
        self.scroll(CGPoint(x: self.contentInsets.right, y: self.contentSize.height))
    }
}

public extension NSTextView {
    /// Scrolls the view to its topmost position.
    func top() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    /// Scrolls the view to its lowest position.
    func bottom() {
        self.scrollRangeToVisible(NSRange(location: self.string.count - 1, length: 1))
    }
}

public extension NSText {
    /**
     Resizes the font to the given size.
     
     - Parameter to: The desired point size for the font.
     */
    func resizeFont(to: CGFloat) {
        guard let newDescriptor = self.font?.fontDescriptor else {
            return
        }
        let newFont = NSFont(descriptor: newDescriptor, size: to)
        self.font = newFont
    }
}
