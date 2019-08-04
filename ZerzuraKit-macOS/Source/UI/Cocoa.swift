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
    
    func topLeftCorner() -> NSPoint {
        let positionX = self.center.x - (self.frame.width/2.0)
        let positionY = self.center.y - (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    func topRightCorner() -> NSPoint {
        let positionX = self.center.x + (self.frame.width/2.0)
        let positionY = self.center.y - (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    func bottomLeftCorner() -> NSPoint {
        let positionX = self.center.x - (self.frame.width/2.0)
        let positionY = self.center.y + (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
    
    func bottomRightCorner() -> NSPoint {
        let positionX = self.center.x + (self.frame.width/2.0)
        let positionY = self.center.y + (self.frame.height/2.0)
        return NSPoint(x: positionX, y: positionY)
    }
}

extension NSTextView {
    /// Scrolls a NSTextView to its top.
    func scrollToTop() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
//    func resize(fontSize: CGFloat) {
//        self.font?.s
//    }
}
