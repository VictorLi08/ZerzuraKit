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

import UIKit

public extension UIImage {
    /**
     Generates a compressed copy of the UIImage.
     
     - Parameter quality: The quality of the compressed image versus the current image.
     
     - Returns: A compressed UIImage.
     */
    func compressed(quality: CGFloat) -> UIImage? {
        guard let _ = self.images else {
            return nil
        }
        
        if quality > 1.0 || quality < 0.0 {
            return self
        } else {
            let imageData = self.jpegData(compressionQuality: quality)
            return UIImage(data: imageData!)
        }
    }
}

public extension UIImageView {
    /**
     Resizes a UIImageView to the given width and height.
     Specifying only one or the other results in a resize that retains the current aspect ratio.
     
     - Parameter width: The desired width (in pixels) of the resulting UIImageView.
     - Parameter height: The desired height (in pixels) of the resulting UIImageView.
     */
    func resize(width: CGFloat?, height: CGFloat?) {
        guard let imageViewImage = self.image else {
            return
        }
        
        let aspectRatio = imageViewImage.size.width / imageViewImage.size.height
        
        var newSize = CGSize()
        if let newWidth = width, let newHeight = height {       // both w/h supplied
            newSize = CGSize(width: newWidth, height: newHeight)
        } else if let newWidth = width {        // w only
            newSize = CGSize(width: newWidth, height: newWidth * aspectRatio)
        } else if let newHeight = height {      // h only
            newSize = CGSize(width: newHeight * aspectRatio, height: newHeight)
        } else {
            return
        }
        
        self.resize(to: newSize)
    }
    
    /**
     Resizes a UIImageView to dimensions given by a frame.
     
     - Parameter size: A CGSize representing the desired dimensions of the UIImageView.
     */
    func resize(to newSize: CGSize) {
        guard var imageViewImage = self.image else {
            return
        }
        
        let renderer = UIGraphicsImageRenderer(size: newSize)      // render new image
        let newImageRectangle = CGRect(origin: CGPoint.zero, size: newSize)
        let resizedImage = renderer.image { _ in
            imageViewImage.draw(in: newImageRectangle)
        }
        
        imageViewImage = resizedImage
    }
    
    /**
     Changes a UIImageView's image and animates the image change with a fade out/fade in animation.
     
     - Parameter image: A UIImage that will be inserted into the view.
     - Parameter duration: The number of seconds it should take for all animations to complete.
     */
    func reshow(image: UIImage, duration: TimeInterval) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0.0        // fade out
            }) { (finished) in
                self.image = image      // change the image
            
                UIView.animate(withDuration: duration, animations: {
                    self.alpha = 1.0        // fade in
                })
            }
        }
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
                    if let image = UIImage(data: imageData) {
                        self.image = image
                        self.sizeToFit()
                    }
                }
            } catch {
                if let label = self.accessibilityLabel {
                    NSLog("[ZerzuraKit] Could not fetch image for image view '\(label)'.")
                } else {
                    NSLog("[ZerzuraKit] Could not fetch image for image view.")
                }
            }
        }
    }
}

