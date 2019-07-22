//
//  Images.swift
//  ZerzuraKit
//
//  Created by Victor Li on 6/19/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Cocoa

extension NSImage {
    /**
     Generates a compressed NSImage.
     
     - Parameter quality: The quality of the compressed image relative to the current image (i.e. 0.7 = 70%).
     
     - Returns: A NSImage compressed to the quality desired.
     */
    public func compressed(quality: Float) -> NSImage? {
        if quality > 1.0 || quality < 0.0 {
            return self
        } else {
            let imageData = self.tiffRepresentation(using: .jpeg, factor: quality)
            return NSImage(data: imageData!)
        }
    }
    
    /**
     Tints the contained image using the tint color specified.
     */
    public func withTintColor(_ color: NSColor) {
        self.contentTintColor = color
        self.image = self.image!.withRenderingMode(NSImage.RenderingMode.alwaysTemplate)
    }
}

extension NSImageView {
    /**
     Resizes a NSImageView to the given width and height.
     Specifying only one or the other results in a resize that retains the current aspect ratio.
     
     - Parameter width: The desired width (in pixels) of the resulting NSImageView.
     - Parameter height: The desired height (in pixels) of the resulting NSImageView.
     */
    public func withSize(width: CGFloat?, height: CGFloat?) {
        let dimensionsGiven = width != nil || height != nil
        let imageSet = self.image != nil
        if dimensionsGiven && imageSet {
            var newSize = NSSize()
            let aspectRatio = self.image!.size.width / self.image!.size.height      // determine the aspect ratio
            
            if width != nil {       // resize using width, keeping aspect ratio
                newSize = NSSize(width: width!, height: width! * aspectRatio)
            } else if height != nil {     // resize using height, keeping aspect ratio
                newSize = NSSize(width: height! * aspectRatio, height: height!)
            } else if width != nil && height != nil {     // resize using both, ignoring aspect ratio
                newSize = NSSize(width: width!, height: height!)
            }
            
            // redraw the image
            let newImage = NSImage(size: newSize)
            newImage.lockFocus()
            self.image!.draw(in: NSMakeRect(self.frame.origin.x, self.frame.origin.y, newSize.width, newSize.height),
                             from: NSMakeRect(self.frame.origin.x, self.frame.origin.y, self.image!.size.width, self.image!.size.height),
                             operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
            
            let existingOrigin = NSPoint(x: self.frame.origin.x, y: self.frame.origin.y)
            self.image!.draw(at: existingOrigin,
                             from: NSMakeRect(self.frame.origin.x, self.frame.origin.y, self.image!.size.width, self.image!.size.height),
                             operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
            
            newImage.unlockFocus()
            newImage.size = newSize
            
            self.image = newImage       // set the image
        }
    }
    
    /**
     Resizes a NSImageView to dimensions given by a frame.
     
     - Parameter frame: A CGSize frame representing the desired dimensions of the NSImageView.
     */
    public func resize(frame: NSRect) {
        
        // redraw the image
        let newImage = NSImage(size: frame.size)
        
        newImage.lockFocus()
        self.image!.draw(in: NSMakeRect(frame.origin.x, frame.origin.y, frame.width, frame.height),
                         from: NSMakeRect(frame.origin.x, frame.origin.y, self.image!.size.width, self.image!.size.height),
                         operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = frame.size
        
        self.image = newImage       // set the image
    }
}
