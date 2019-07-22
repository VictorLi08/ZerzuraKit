//
//  UI.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/7/13.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    public func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    public func fadeOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    public func flash(cycles: Int) {
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
    public func scrollToTop() {
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    public func resize(fontSize: CGFloat) {
        self.font = self.font!.withSize(fontSize)
    }
}

extension UIImage {
    /**
     Generates a compressed copy of the UIImage.
     
     - Parameter quality: The quality of the compressed image relative to the current image (i.e. 0.7 = 70%).
     
     - Returns: A UIImage compressed to the quality desired.
     */
    public func compressed(quality: CGFloat) -> UIImage? {
        if quality > 1.0 || quality < 0.0 {
            return self
        } else {
            let imageData = self.jpegData(compressionQuality: quality)
            return UIImage(data: imageData!)
        }
    }
}

extension UIImageView {
    /**
     Resizes a UIImageView to the given width and height.
     Specifying only one or the other results in a resize that retains the current aspect ratio.
     
     - Parameter width: The desired width (in pixels) of the resulting UIImageView.
     - Parameter height: The desired height (in pixels) of the resulting UIImageView.
     */
    public func withSize(width: CGFloat?, height: CGFloat?) {
        let dimensionsGiven = width != nil || height != nil
        let imageSet = self.image != nil
        if dimensionsGiven && imageSet {
            var newSize = CGSize()
            let aspectRatio = self.image!.size.width / self.image!.size.height      // determine the aspect ratio
            
            if width != nil {       // resize using width, keeping aspect ratio
                newSize = CGSize(width: width!, height: width! * aspectRatio)
            } else if height != nil {     // resize using height, keeping aspect ratio
                newSize = CGSize(width: height! * aspectRatio, height: height!)
            } else if width != nil && height != nil {     // resize using both, ignoring aspect ratio
                newSize = CGSize(width: width!, height: height!)
            }
            
            let renderer = UIGraphicsImageRenderer(size: newSize)
            let resizedImage = renderer.image { _ in
                self.image!.draw(in: CGRect.init(origin: frame.origin, size: newSize))      // render the new image
            }
            
            self.image = resizedImage       // set the image
        }
    }
    
    /**
     Resizes a UIImageView to dimensions given by a frame.
     
     - Parameter size: A CGSize representing the desired dimensions of the UIImageView.
     */
    public func withSize(size: CGSize) {
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { _ in
            self.image!.draw(in: CGRect.init(origin: CGPoint.zero, size: size))        // render the new image
        }
        
        self.image = resizedImage       // set the image
    }
    
    /**
     Changes a UIImageView's image and animates the image change with a fade out/fade in animation.
     
     - Parameter image: A UIImage that will be inserted into the view.
     - Parameter duration: The amount of time desired for each animation.
     */
    public func reshow(image: UIImage, duration: TimeInterval) {
        DispatchQueue.main.async {      // fade out
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0.0
            }) { (finished) in
                self.image = image      // change the image
            
                UIView.animate(withDuration: duration, animations: {        // fade in
                    self.alpha = 1.0
                })
            }
        }
    }
}

