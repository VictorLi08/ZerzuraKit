//
//  Views.swift
//  ZerzuraKit-macOS
//
//  Created by Victor Li on 2019/8/2.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Cocoa

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
    
    var topLeftCorner: NSPoint {
        let positionX = self.frame.origin.x - (self.frame.width/2.0)
        let positionY = self.frame.origin.y - (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    var topRightCorner: NSPoint {
        let positionX = self.frame.origin.x + (self.frame.width/2.0)
        let positionY = self.frame.origin.y - (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    var bottomLeftCorner: NSPoint {
        let positionX = self.frame.origin.x - (self.frame.width/2.0)
        let positionY = self.frame.origin.y + (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    var bottomRightCorner: NSPoint {
        let positionX = self.frame.origin.x + (self.frame.width/2.0)
        let positionY = self.frame.origin.y + (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    var center: NSPoint {
        let positionX = self.frame.origin.x
        let positionY = self.frame.origin.y
        return NSPoint(x: positionX, y: positionY)
    }
}

extension NSScrollView {
    /// Scrolls the view to its topmost position.
    func scrollUpToTop() {
        self.scroll(CGPoint(x: self.contentInsets.left, y: self.contentInsets.top))
    }
}


extension NSTextView {
    func scrollUpToTop() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
}

extension NSText {
    func resize(fontSize: CGFloat) {
        guard let newDescriptor = self.font?.fontDescriptor else {
            return
        }
        let newFont = NSFont(descriptor: newDescriptor, size: fontSize)
        self.font = newFont
    }
}
