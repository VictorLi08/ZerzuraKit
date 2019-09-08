//
//  Images.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/8/2.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import UIKit

extension UIImage {
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

extension UIImageView {
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

