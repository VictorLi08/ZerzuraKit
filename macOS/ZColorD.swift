//
//    Colors.swift
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

extension ZColor {
    /**
     Generates a NSColor from stored color values.

     - Returns: A NSColor initialized using stored color values.
    */
    func get() -> NSColor {
        return ZColor.hex(hexString: self.hexString, alpha: self.a)
    }

    /**
     Generates a NSColor from sRGB color components.

     - Parameter r: Red (0.0 to 255.0).
     - Parameter g: Green (0.0 to 255.0).
     - Parameter b: Blue (0.0 to 255.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.

     - Returns: A NSColor initialized using the provided component values.
    */
    static func srgb(r: Double, g: Double, b: Double, a: Double? = 1.0) -> NSColor {
        let redComponent = CGFloat(Double(r)/256.0)
        let greenComponent = CGFloat(Double(g)/256.0)
        let blueComponent = CGFloat(Double(b)/256.0)
        let alphaComponent = CGFloat(Double(a!))
        return NSColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: alphaComponent)
    }

    /**
     Generates a NSColor from HSV/HSL color components.

     - Parameter h: Hue (0.0 to 360.0).
     - Parameter s: Saturation (0.0 to 100.0).
     - Parameter v: Value or Lightness (0.0 to 100.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.

     - Returns: A NSColor initialized using the provided component values.
    */
    static func hsv(h: Double, s: Double, v: Double, a: Double? = 0.0) -> NSColor {
        let hue = CGFloat(h % 360.0)
        let sat = CGFloat(s % 360.0)
        let bright = CGFloat(v % 360.0)
        return NSColor(hue: hue, saturation: sat, brightness: bright, alpha: CGFloat(a!))
    }

    /**
     Generates a NSColor from CMYK color components.

     - Parameter c: Cyan (0.0 to 100.0).
     - Parameter m: Magenta (0.0 to 100.0).
     - Parameter y: Yellow (0.0 to 100.0).
     - Parameter k: Key (0.0 to 100.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.

     - Returns: A NSColor initialized using the provided component values.
    */
    static func cmyk(c: Double, m: Double, y: Double, k: Double) -> NSColor {
       let rgb = ZColor.convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .srgb)
       guard let red = Double(rgb[0]), let green = Double(rgb[1]), let blue = Double(rgb[2]) else {
           return NSColor.white
       }
       return srgb(r: red, g: green, b: blue, a: 1.0)
    }

    /**
     Generates a NSColor from a hexidecimal string.

     - Parameter hexString: A string containing a hexidecimal color value without the pound sign. Case does not matter.
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.

     - Returns: A NSColor initialized using the provided hex value.
    */
    static func hex(hexString: String, alpha: Double? = 0.0) -> NSColor {
        let h = convert(values: [hexString], from: .hex, to: .srgb)
        guard let red = Double(h[0]), let green = Double(h[1]), let blue = Double(h[2]) else {
           return NSColor.white
        }
        return srgb(r: red, g: green, b: blue, a: alpha)
    }
}
