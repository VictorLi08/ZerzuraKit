//
//  Views.swift
//  ZerzuraKit-macOS
//
//  Created by Victor Li on 2019/8/2.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Cocoa

extension NSWindow {
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

extension NSView {
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

extension NSScrollView {
    /// Scrolls the view to its topmost position.
    func top() {
        self.scroll(CGPoint(x: self.contentInsets.left, y: self.contentInsets.top))
    }
    
    /// Scrolls the view to its lowest position.
    func bottom() {
        self.scroll(CGPoint(x: self.contentInsets.right, y: self.contentSize.height))
    }
}


extension NSTextView {
    /// Scrolls the view to its topmost position.
    func top() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    /// Scrolls the view to its lowest position.
    func bottom() {
        self.scrollRangeToVisible(NSRange(location: self.string.count - 1, length: 1))
    }
}

extension NSText {
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
