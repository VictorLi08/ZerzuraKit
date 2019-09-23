# ZerzuraKit
ZerzuraKit is a versatile Swift framework that brings a ton of convenience features to developing for Apple platforms. Code intuitively, organize seamlessly, and implement complex functionality using lightweight syntax.

---
:warning: __WARNING__ :warning:

ZerzuraKit is currently under active development and is being distributed in a pre-release state with incomplete testing. Unexpected behavior is normal as functionality is refined. Please contribute by opening an issue!

---

## Features
- [x] Color management methods for sRGB, HSV, Hex, and CMYK color spaces
- [x] Quick address decoding and CLLocation data storage
- [x] Date and TimeInterval string generation and localization
- [x] C++ style unary and binary operators for computing/converting numbers
- [x] Array subset, intersection, difference, and equivalence convenience methods
- [x] Abstract data types
    - [x] Bags
    - [x] FIFOs
    - [x] LIFOs (Stacks)
- [x] Additional convenience methods and properties for modifying UI elements
- [x] Quick image compression, resize, and asynchronous web fetch/display
- [x] Precise determination of device region/locale

## Usage
- [Getting Started](Documentation/GettingStarted.md)
- [Arrays](Documentation/Arrays.md)
- [Abstract Data Types](Documentation/ADTs.md)
- [Date and Time](Documentation/DT.md)
- [Numbers](Documentation/Nums.md)
- [UI Elements](Documentation/UI.md)
- [Device Properties](Documentation/Device.md)
- [ZLocation](Documentation/ZLocation.md)

## Installation
### CocoaPods
To integrate ZerzuraKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

``` ruby
pod 'ZerzuraKit'
```

and run `pod install`.

### Manually (Xcode 11 or newer)
- Download and decompress an  `.xcframework` package from Releases.
- Add `ZerzuraKit.xcframework` to your Xcode project under `Frameworks, Libraries, and Embedded Content`.

This method is recommended if you want to minimize build time.

## Requirements
- iOS 10+, watchOS 2.0+, tvOS 10+, or macOS 10.10+
- Swift 5.1+

## License
MIT License
