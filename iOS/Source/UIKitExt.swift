//
//  UI.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/7/13.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Fades the view out in the given timeframe and then sets its alpha to 0.
     
     - Parameter duration: The number of seconds it should take for the animation to complete.
     */
    func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
    Fades the view in within the given timeframe and then sets its alpha to 1.
    
    - Parameter duration: The number of seconds it should take for the animation to complete.
    */
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
    @objc func top() {
        self.setContentOffset(.zero, animated: true)
    }
    
    /// Scrolls the view to its lowest position.
    @objc func bottom() {
        let viewBottom = CGPoint(x: 0, y: self.contentSize.height - self.bounds.height + self.contentInset.bottom)
        self.setContentOffset(viewBottom, animated: true)
    }
}

extension UITextView {
    /// Scrolls the view to its topmost position.
    override func top() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    /// Scrolls the view to its lowest position.
    override func bottom() {
        self.scrollRangeToVisible(NSRange(location: self.text.count - 1, length: 1))
    }
    
    /**
    Resizes the font to the given size.
    
    - Parameter to: The desired point size for the font.
    */
    func resizeFont(to: CGFloat) {
        if let font = self.font {
            self.font = font.withSize(to)
        }
    }
}


