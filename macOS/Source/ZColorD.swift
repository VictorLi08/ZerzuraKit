//
//  Colors.swift
//  ZerzuraKit
//
//  Created by Victor Li on 5/9/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Cocoa

extension ZColor {
    /**
     Generates a NSColor from stored color values.

     - Returns: A NSColor initialized using stored color values.
    */
    func get() -> NSColor {
        return ZColor.hex(hexString: self.hexString, a: self.a)
    }

    /**
     Generates a NSColor from sRGB color components.

     - Parameter r: Red (0.0 to 255.0).
     - Parameter g: Green (0.0 to 255.0).
     - Parameter b: Blue (0.0 to 255.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.

     - Returns: A NSColor initialized using the provided component values.
    */
    static func srgb(r: Double, g: Double, b: Double, a: Double? = 0.0) -> NSColor {
        return NSColor(red: CGFloat(Double(r)/256.0), green: CGFloat(Double(g)/256.0), blue: CGFloat(Double(b)/256.0), alpha: CGFloat(Double(a!)))
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
        let hue = CGFloat(h.truncatingRemainder(dividingBy: 360.0))
        let sat = CGFloat(s.truncatingRemainder(dividingBy: 360.0))
        let bright = CGFloat(v.truncatingRemainder(dividingBy: 360.0))

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
       let rgb = convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .srgb)
       guard let r = Double(rgb[0]), let g = Double(rgb[1]), let b = Double(rgb[2]) else {
           return NSColor.white
       }
       return srgb(r: r, g: g, b: b, a: 1.0)
    }

    /**
     Generates a NSColor from a hexidecimal string.

     - Parameter hexString: A string containing a hexidecimal color value without the pound sign. Case does not matter.
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.

     - Returns: A NSColor initialized using the provided hex value.
    */
    static func hex(hexString: String, a: Double? = 0.0) -> NSColor {
        let h = convert(values: [hexString], from: .hex, to: .srgb)

        // use srgb to return the correct color
        guard let r = Double(h[0]), let g = Double(h[1]), let b = Double(h[2]) else {
           return NSColor.white
        }
        return srgb(r: r, g: g, b: b, a: a)
    }
}
