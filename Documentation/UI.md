#  UI Elements

ZerzuraKit's UI extensions simplify interacting with UI elements.

## Imports
If developing for iOS, watchOS, or tvOS:
``` swift
import UIKit
```

If developing for macOS:
``` swift
import Cocoa
```

## Quick Scrolling
UIScrollViews, UITextViews, and their Cocoa equivalents (NSScrollView, NSTextView) can be quickly scrolled to the top or bottom of their visible content range in one step.

``` swift
myScrollView.top()
myScrollView.bottom()
```

## Font Resize
Quickly resize fonts in a UITextView, NSText, or NSTextView.

``` swift
myTextView.resizeFont(to: 12)
```

## Images
### Compression
You can produce a compressed UIImage or NSImage of a specified quality without affecting the original image itself:

``` swift
let compressedImage = myImage.compressed(quality: 0.5)    // 50% quality
```

### Resize
You can quickly resize a UIImageView or NSImageView based on explicit dimensions or size. Resizing with only one of two dimensions (width or height) will retain an image's aspect ratio, perfect for fitting images inside a certain screen area.

``` swift
myImage.resize(width: 100)    // 100px width, retain aspect ratio
```

### Fetch and Display
You can populate a UIImageView or NSImageView with a web image through one simple command:

``` swift
myImageView.imageFromURL("https://www.example.com/image.jpg")
```


:warning: __WARNING__ :warning:

Attempting to access insecure resources (i.e. http:// instead of https:// URLs) will fail due to App Transport Security. Avoid attempting to turn that off; Apple will not accept apps with ATS turned off without good reason.
