//
//  UI.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/7/13.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import UIKit

extension UIView {
    func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func topLeftCorner() -> CGPoint {
        let positionX = self.center.x - (self.frame.width/2.0)
        let positionY = self.center.y - (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
    
    func topRightCorner() -> CGPoint {
        let positionX = self.center.x + (self.frame.width/2.0)
        let positionY = self.center.y - (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
    
    func bottomLeftCorner() -> CGPoint {
        let positionX = self.center.x - (self.frame.width/2.0)
        let positionY = self.center.y + (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
    
    func bottomRightCorner() -> CGPoint {
        let positionX = self.center.x + (self.frame.width/2.0)
        let positionY = self.center.y + (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
}

extension UITextView {
    /// Scrolls a UITextView to its top.
    func scrollToTop() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    func resize(fontSize: CGFloat) {
        self.font = self.font!.withSize(fontSize)
    }
}
