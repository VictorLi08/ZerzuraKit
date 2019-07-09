//
//  Images.swift
//  ZerzuraKit
//
//  Created by Victor Li on 6/19/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    /**
     Generates a compressed UIImage.
     
     - Parameter quality: The quality of the compressed image relative to the current image (i.e. 0.7 = 70%).
     
     - Returns: A UIImage compressed to the quality desired.
     */
    public func compress(quality: CGFloat) -> UIImage? {
        if quality > 1.0 || quality < 0.0 {
            return self
        }
        else {
            let imageData = self.jpegData(compressionQuality: quality)
            return UIImage(data: imageData!)
        }
    }
}

extension UIImageView {
    /// Allows the image contained to be tinted.
    public func enableTint() {
        self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    
    /**
     Resizes a UIImageView to the given width and height.
     Specifying only one or the other results in a resize that retains the current aspect ratio.
     
     - Parameter width: The desired width (in pixels) of the resulting UIImageView.
     - Parameter height: The desired height (in pixels) of the resulting UIImageView.
     */
    public func resize(width: CGFloat?, height: CGFloat?) {
        let dimensionsGiven = width != nil || height != nil
        let imageSet = self.image != nil
        if dimensionsGiven && imageSet {
            var newSize = CGSize()
            let aspectRatio = self.image!.size.width / self.image!.size.height      // determine the aspect ratio
            
            if width != nil {       // resize using width, keeping aspect ratio
                newSize = CGSize(width: width!, height: width! * aspectRatio)
            }
            else if height != nil {     // resize using height, keeping aspect ratio
                newSize = CGSize(width: height! * aspectRatio, height: height!)
            }
            else if width != nil && height != nil {     // resize using both, ignoring aspect ratio
                newSize = CGSize(width: width!, height: height!)
            }
            
            let renderer = UIGraphicsImageRenderer(size: newSize)
            let resizedImage = renderer.image { _ in
                self.image!.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))      // render the new image
            }
            
            self.image = resizedImage       // set the image
        }
    }
    
    /**
     Resizes a UIImageView to dimensions given by a frame.
     
     - Parameter frame: A CGSize frame representing the desired dimensions of the UIImageView.
     */
    public func resize(frame: CGSize) {
        let renderer = UIGraphicsImageRenderer(size: frame)
        let resizedImage = renderer.image { _ in
            self.image!.draw(in: CGRect.init(origin: CGPoint.zero, size: frame))        // render the new image
        }
        
        self.image = resizedImage       // set the image
    }
}
