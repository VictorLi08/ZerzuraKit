# ZerzuraKit
ZerzuraKit is a versatile framework for iOS and macOS that bundles a diverse set of methods and extensions into a streamlined package. Have at your disposal an extensive library of convenient methods that allow you to code intuitively and implement complex functionality using lightweight syntax.

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
- [ ] Abstract data types
    - [x] Bags
    - [ ] Stacks
    - [ ] Multimaps
- [x] Additional convenience methods and properties for modifying UI elements
- [x] Quick image compression, resize, and asynchronous web fetch/display
- [x] Precise determination of device region/locale

## Usage
``` swift
import ZerzuraKit
```

ZerzuraKit extends many existing Apple libraries and defines a few new classes of its own. Read documentation on how to use ZerzuraKit by visiting the [ZerzuraKit wiki](https://github.com/VictorLi08/ZerzuraKit/wiki).  

## Installation
### CocoaPods
To integrate ZerzuraKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

``` ruby
pod 'ZerzuraKit'
```

and run `pod install`.

### Manually (Xcode 11+)
- Clone this repository or download an `.xcframework` package from Releases.
- Add `ZerzuraKit.xcframework` to your Xcode project under `Frameworks, Libraries, and Embedded Content`.

## Requirements
- iOS 10+, watchOS 2.0+, tvOS 10+, or macOS 10.10+
- Swift 5.1

## License
MIT License
