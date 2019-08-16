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
    func compressed(quality: Float) -> NSImage? {
        if quality > 1.0 || quality < 0.0 {
            return self
        } else {
            let imageData = self.tiffRepresentation(using: .jpeg, factor: quality)
            return NSImage(data: imageData!)
        }
    }
}

extension NSImageView {
    /**
     Resizes a NSImageView to the given width and height.
     Specifying only one or the other results in a resize that retains the current aspect ratio.
     
     - Parameter width: The desired width (in pixels) of the resulting NSImageView.
     - Parameter height: The desired height (in pixels) of the resulting NSImageView.
     */
    func withSize(width: CGFloat?, height: CGFloat?) {
        guard let img = self.image else {
            return
        }
        
        let aspectRatio = img.size.width / img.size.height      // determine the aspect ratio
        
        var newSize = NSSize()
        if let w = width, let h = height {      // resize using both, ignoring aspect ratio
            newSize = NSSize(width: w, height: h)
        } else if let w = width {       // resize using width, keeping aspect ratio
            newSize = NSSize(width: w, height: w * aspectRatio)
        } else if let h = height {      // resize using height, keeping aspect ratio
            newSize = NSSize(width: h * aspectRatio, height: h)
        } else {
            return
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
    
    /**
     Resizes a NSImageView to dimensions given by a frame.
     
     - Parameter frame: A CGSize frame representing the desired dimensions of the NSImageView.
     */
    func resize(frame: NSRect) {
        
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
    
    /**
     Fetches an image asynchronously and displays it in the image view.
     Logged errors will reference the culprit image view if its accessibility label has been set.
     
     - Parameter: An HTTP URL to the desired image resource.
     */
    func imageFromURL(_ url: URL) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let imageData = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if let image = NSImage(data: imageData) {
                        self.image = image
                        self.sizeToFit()
                    }
                }
            } catch {
                if let label = self.accessibilityLabel() {
                    NSLog("[ZerzuraKit] Could not fetch image for image view '\(label)'.")
                } else {
                    NSLog("[ZerzuraKit] Could not fetch image for image view.")
                }
            }
        }
    }
}
