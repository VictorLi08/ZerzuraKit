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
    
    func flash(cycles: Int) {
        if self.alpha < 1.0 {
            for _ in 1 ... cycles {
                self.fadeIn(duration: 0.1)
                self.fadeOut(duration: 0.1)
            }
        } else {
            for _ in 1 ... cycles {
                self.fadeOut(duration: 0.1)
                self.fadeIn(duration: 0.1)
            }
        }
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
