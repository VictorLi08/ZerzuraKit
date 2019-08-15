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
    
    /// The position of the view's upper left-hand corner.
    var topLeftCorner: CGPoint {
        let positionX = self.center.x - (self.frame.width/2.0)
        let positionY = self.center.y - (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
    
    /// The position of the view's upper right-hand corner.
    var topRightCorner: CGPoint {
        let positionX = self.center.x + (self.frame.width/2.0)
        let positionY = self.center.y - (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
    
    /// The position of the view's lower left-hand corner.
    var bottomLeftCorner: CGPoint {
        let positionX = self.center.x - (self.frame.width/2.0)
        let positionY = self.center.y + (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
    
    /// The position of the view's lower right-hand corner.
    var bottomRightCorner: CGPoint {
        let positionX = self.center.x + (self.frame.width/2.0)
        let positionY = self.center.y + (self.frame.height/2.0)
        return CGPoint(x: positionX, y: positionY)
    }
}

extension UIScrollView {
    /// Scrolls the view to its topmost position.
    @objc func scrollToTop() {
        self.setContentOffset(.zero, animated: true)
    }
    
    @objc func scrollToBottom() {
        let viewBottom = CGPoint(x: 0, y: self.contentSize.height - self.bounds.height + self.adjustedContentInset.bottom)
        self.setContentOffset(viewBottom, animated: true)
    }
}

extension UITextView {
    override func scrollToTop() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    override func scrollToBottom() {    
        self.scrollRangeToVisible(NSRange(location: self.text.count - 1, length: 1))
    }
    
    func resize(fontSize: CGFloat) {
        if let font = self.font {
            self.font = font.withSize(fontSize)
        }
    }
}


