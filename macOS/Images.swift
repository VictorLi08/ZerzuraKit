//
//    Images.swift
//    ZerzuraKit
//
//    Copyright (c) 2019 Victor Li
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Cocoa

public extension NSImage {
    /**
     Generates a compressed NSImage.
     
     - Parameter quality: The quality of the compressed image versus the current image.
     
     - Returns: The compressed NSImage.
     */
    func compressed(quality: Float) -> NSImage? {
        guard let _ = self.tiffRepresentation else {
            return nil
        }
        
        if quality > 1.0 || quality < 0.0 {
            return self
        } else {
            let imageData = self.tiffRepresentation(using: .jpeg, factor: quality)
            return NSImage(data: imageData!)
        }
    }
}

public extension NSImageView {
    /**
     Resizes a NSImageView to the given width and height.
     Specifying only one or the other results in a resize that retains the current aspect ratio.
     
     - Parameter width: The desired width (in pixels) of the resulting NSImageView.
     - Parameter height: The desired height (in pixels) of the resulting NSImageView.
     */
    func resize(width: CGFloat?, height: CGFloat?) {
        guard let existingImage = self.image else {
            return
        }
        
        let aspectRatio = existingImage.size.width / existingImage.size.height
        
        var newSize = NSSize()
        if let newWidth = width, let newHeight = height {       // both w/h supplied
            newSize = NSSize(width: newWidth, height: newHeight)
        } else if let newWidth = width {        // w only
            newSize = NSSize(width: newWidth, height: newWidth * aspectRatio)
        } else if let newHeight = height {      // h only
            newSize = NSSize(width: newHeight * aspectRatio, height: newHeight)
        } else {
            return
        }
        
        self.resize(to: newSize)
    }
    
    /**
     Resizes a NSImageView to a given size.
     
     - Parameter frame: A rectangle representing the desired dimensions of the NSImageView.
     */
    func resize(to newSize: NSSize) {
        guard var existingImage = self.image else {
            return
        }
        
        let newFrame = NSRect(origin: .zero, size: newSize)
        guard let existingImageData = existingImage.bestRepresentation(for: newFrame, context: nil, hints: nil) else {
            return
        }
        
        let newImage = NSImage(size: newSize, flipped: false, drawingHandler: { (_) -> Bool in
            return existingImageData.draw(in: newFrame)
        })
        
        existingImage = newImage
    }
    
    /**
     Fetches an image asynchronously and displays it in the image view.
     Logged errors will reference the culprit image view if its accessibility label has been set.
     
     - Parameter url: An HTTP URL to the desired image resource.
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
