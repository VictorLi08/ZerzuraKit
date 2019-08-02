//
//  Colors.swift
//  ZerzuraKit
//
//  Created by Victor Li on 5/9/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Cocoa

/**
 An object that stores and handles conversion of color and opacity (alpha value) data.
*/
public class ZColor {
    /// The stored color value in hexidecimal.
    public private(set) var hexString : String = "000000"
    /// The stored color's alpha (opacity) value.
    public private(set) var a : Double = 1.0
    
    /// The stored color's red color component (sRGB).
    public private(set) var r : Double = 0.0
    /// The stored color's green color component (sRGB).
    public private(set) var g : Double = 0.0
    /// The stored color's blue color component (sRGB).
    public private(set) var b : Double = 0.0
    /// The stored color's hue (HSV).
    public private(set) var h : Double = 0.0
    /// The stored color's saturation (HSV).
    public private(set) var s : Double = 0.0
    /// The stored color's value or lightness (HSV).
    public private(set) var v : Double = 0.0
    /// The stored color's cyan color component (CMYK).
    public private(set) var c : Double = 0.0
    /// The stored color's magenta color component (CMYK).
    public private(set) var m : Double = 0.0
    /// The stored color's yellow color component (CMYK).
    public private(set) var y : Double = 0.0
    /// The stored color's key color component (CMYK).
    public private(set) var k : Double = 1.0
    
    /**
     All supported color spaces.
    */
    public enum ColorSpace {
        /// sRGB (Adobe) color space.
        case srgb
        /// Hexidecimal color value.
        case hex
        /// HSV/HSL color space.
        case hsv
        /// CMYK color space.
        case cmyk
    }
    
    // constructors
    /**
     Instantiates a ZColor holding #000000 (black) at 1.0 alpha (fully opaque).
    */
    public init() {
        
    }
    
    /**
     Instantiates a ZColor using sRGB color components.
     
     - Parameter r: Red (0.0 to 255.0).
     - Parameter g: Green (0.0 to 255.0).
     - Parameter b: Blue (0.0 to 255.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public init(r: Double, g: Double, b: Double, a: Double? = 0.0) {
        self.set(r: r, g: g, b: b, a: a)
    }
    
    /**
     Instantiates a ZColor using HSV/HSL color components.
     
     - Parameter h: Hue (0.0 to 360.0).
     - Parameter s: Saturation (0.0 to 100.0).
     - Parameter v: Value or Lightness (0.0 to 100.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public init(h: Double, s: Double, v: Double, a: Double? = 0.0) {
        self.set(h: h, s: s, v: v, a: a)
    }
    
    /**
     Instantiates a ZColor using CMYK color components.
     
     - Parameter c: Cyan (0.0 to 100.0).
     - Parameter m: Magenta (0.0 to 100.0).
     - Parameter y: Yellow (0.0 to 100.0).
     - Parameter k: Key (0.0 to 100.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public init(c: Double, m: Double, y: Double, k: Double, a: Double? = 0.0) {
        self.set(c: c, m: m, y: y, k: k, a: a)
    }
    
    /**
     Instantiates a ZColor using a hexidecimal color value.
     
     # Usage Example #
     ````
     let amber = ZColor.init(hexString: "FFBF00")
     ````
     
     - Parameter hexString: A string containing a hexidecimal color value without the pound sign. Case does not matter.
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public init(hexString: String, a: Double? = 0.0) {
        self.set(hexString: hexString, a: a)
    }
    
    // setters
    /**
     Resets a ZColor using sRGB color components.
     
     - Parameter r: Red (0.0 to 255.0).
     - Parameter g: Green (0.0 to 255.0).
     - Parameter b: Blue (0.0 to 255.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public func set(r: Double, g: Double, b: Double, a: Double? = 0.0) {
        self.a = a!
        
        // SRGB
        self.r = r
        self.g = g
        self.b = b
        
        // HEX
        let hexed = ZColor.convert(values: [String(r), String(g), String(b)], from: .srgb, to: .hex)
        self.hexString = hexed.first!
        
        // CMYK
        let cmyked = ZColor.convert(values: [String(r), String(g), String(b)], from: .srgb, to: .cmyk)
        self.c = Double(cmyked[0])!
        self.m = Double(cmyked[1])!
        self.y = Double(cmyked[2])!
        self.k = Double(cmyked[3])!
        
        // HSV
        let hsved = ZColor.convert(values: [String(r), String(g), String(b)], from: .srgb, to: .hsv)
        self.h = Double(hsved[0])!
        self.s = Double(hsved[1])!
        self.v = Double(hsved[2])!
    }
    
    /**
     Resets a ZColor using HSV/HSL color components.
     
     - Parameter h: Hue (0.0 to 360.0).
     - Parameter s: Saturation (0.0 to 100.0).
     - Parameter v: Value or Lightness (0.0 to 100.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public func set(h: Double, s: Double, v: Double, a: Double? = 0.0) {
        self.a = a!
        
        // HSV
        self.h = h
        self.s = s
        self.v = v
        
        // SRGB
        let srgbed = ZColor.convert(values: [String(h), String(s), String(v)], from: .hsv, to: .srgb)
        self.r = Double(srgbed[0])!
        self.g = Double(srgbed[1])!
        self.b = Double(srgbed[2])!
        
        // HEX
        let hexed = ZColor.convert(values: [String(h), String(s), String(v)], from: .hsv, to: .hex)
        self.hexString = hexed.first!
        
        // CMYK
        let cmyked = ZColor.convert(values: [String(h), String(s), String(v)], from: .hsv, to: .cmyk)
        self.c = Double(cmyked[0])!
        self.m = Double(cmyked[1])!
        self.y = Double(cmyked[2])!
        self.k = Double(cmyked[3])!
    }
    
    /**
     Resets a ZColor using CMYK color components.
     
     - Parameter c: Cyan (0.0 to 100.0).
     - Parameter m: Magenta (0.0 to 100.0).
     - Parameter y: Yellow (0.0 to 100.0).
     - Parameter k: Key (0.0 to 100.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public func set(c: Double, m: Double, y: Double, k: Double, a: Double? = 0.0) {
        self.a = a!
        
        // CMYK
        self.c = c
        self.m = m
        self.y = y
        self.k = k
        
        // SRGB
        let srgbed = ZColor.convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .srgb)
        self.r = Double(srgbed[0])!
        self.g = Double(srgbed[1])!
        self.b = Double(srgbed[2])!
        
        // HEX
        let hexed = ZColor.convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .hex)
        self.hexString = hexed.first!
        
        // HSV
        let hsved = ZColor.convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .hsv)
        self.h = Double(hsved[0])!
        self.s = Double(hsved[1])!
        self.v = Double(hsved[2])!
    }
    
    /**
     Instantiates a ZColor using a hexidecimal color value.
     
     # Usage Example #
     ````
     let amber = ZColor.init(hexString: "FFBF00")
     ````
     
     - Parameter hexString: A string containing a hexidecimal color value without the pound sign. Case does not matter.
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
    */
    public func set(hexString: String, a: Double? = 0.0) {
        self.a = a!
        
        // HEX
        self.hexString = ZColor.cleanHexString(hexString: hexString)
        
        // SRGB
        let srgbed = ZColor.convert(values: [hexString], from: .hex, to: .srgb)
        self.r = Double(srgbed[0])!
        self.g = Double(srgbed[1])!
        self.b = Double(srgbed[2])!
        
        // HSV
        let hsved = ZColor.convert(values: [hexString], from: .hex, to: .hsv)
        self.h = Double(hsved[0])!
        self.s = Double(hsved[1])!
        self.v = Double(hsved[2])!
        
        // CMYK
        let cmyked = ZColor.convert(values: [hexString], from: .hex, to: .cmyk)
        self.c = Double(cmyked[0])!
        self.m = Double(cmyked[1])!
        self.y = Double(cmyked[2])!
        self.k = Double(cmyked[3])!
    }
    
    // instanced functions
    /**
     Generates a NSColor from stored color values.
 
     - Returns: A NSColor initialized using stored color values.
    */
    public func get() -> NSColor {
        return ZColor.hex(hexString: self.hexString, a: self.a)
    }
    
    /**
     Tests for equality between two ZColor objects.
     
     - Returns: True or False if the two objects hold the same color.
    */
    public static func ==(lhs: ZColor, rhs: ZColor) -> Bool {
        return (lhs.r == rhs.r) && (lhs.g == rhs.g) && (lhs.b == rhs.b) && (lhs.h == rhs.h) && (lhs.s == rhs.s) && (lhs.v == rhs.v) && (lhs.c == rhs.c) && (lhs.m == rhs.m) && (lhs.y == rhs.y) && (lhs.k == rhs.k) && (lhs.hexString == rhs.hexString) && (lhs.a == rhs.a)
    }
    
    // static main color return functions for iOS
    /**
     Generates a NSColor from sRGB color components.
 
     - Parameter r: Red (0.0 to 255.0).
     - Parameter g: Green (0.0 to 255.0).
     - Parameter b: Blue (0.0 to 255.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
 
     - Returns: A NSColor initialized using the provided component values.
    */
    public static func srgb(r: Double, g: Double, b: Double, a: Double? = 0.0) -> NSColor {
        return NSColor.init(red: CGFloat(Double(r)/256.0), green: CGFloat(Double(g)/256.0), blue: CGFloat(Double(b)/256.0), alpha: CGFloat(Double(a!)))
    }
    
    /**
     Generates a NSColor from HSV/HSL color components.
     
     - Parameter h: Hue (0.0 to 360.0).
     - Parameter s: Saturation (0.0 to 100.0).
     - Parameter v: Value or Lightness (0.0 to 100.0).
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
     
     - Returns: A NSColor initialized using the provided component values.
    */
    public static func hsv(h: Double, s: Double, v: Double, a: Double? = 0.0) -> NSColor {
        return NSColor.init(hue: CGFloat(Double(h).truncatingRemainder(dividingBy: 360.0)), saturation: CGFloat(Double(s).truncatingRemainder(dividingBy: 360.0)), brightness: CGFloat(Double(v).truncatingRemainder(dividingBy: 360.0)), alpha: CGFloat(Double(a!)))
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
    public static func cmyk(c: Double, m: Double, y: Double, k: Double) -> NSColor {
        return NSColor.white
    }
    
    /**
     Generates a NSColor from a hexidecimal string.
     
     - Parameter hexString: A string containing a hexidecimal color value without the pound sign. Case does not matter.
     - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
     
     - Returns: A NSColor initialized using the provided hex value.
    */
    public static func hex(hexString: String, a: Double? = 0.0) -> NSColor {
        let h = convert(values: [hexString], from: .hex, to: .srgb)
        
        // use srgb to return the correct color
        return srgb(r: Double(h[0])!, g: Double(h[1])!, b: Double(h[2])!, a: a)
    }
    
    /**
     Converts color components from one color space to another.
 
     - Parameter values: A list of color component values in String format.
     - Parameter from: The color space of the provided color values.
     - Paraemter to: The color space to be converted to.
 
     - Returns: A list of color component values in String format.
    */
    public static func convert(values: [String], from: ZColor.ColorSpace, to: ZColor.ColorSpace) -> [String] {
        let inputValues = self.copyInputs(values: values, from: from)
        
        // begin conversion
        if from == .srgb {
            if to == .hex {
                var hexString = ""
                for item in inputValues {
                    hexString.append(String(format:"%02X", Int(Double(item)!)).lowercased())
                }
                return [hexString]
            }
            else if to == .hsv {
                return srgbToHsv(values: inputValues)
            }
            else if to == .cmyk {
                return srgbToCMYK(values: inputValues)
            }
        }
        else if from == .hsv {
            if to == .srgb {
                return hsvToSRGB(values: inputValues)
            }
            else if to == .hex {
                let intermediateValues = convert(values: inputValues, from: .hsv, to: .srgb)
                return convert(values: intermediateValues, from: .srgb, to: .hex)
            }
            else if to == .cmyk {
                let intermediateValues = convert(values: inputValues, from: .hsv, to: .srgb)
                return convert(values: intermediateValues, from: .srgb, to: .cmyk)
            }
        }
        else if from == .hex {
            if to == .srgb {
                return hexToSRGB(values: inputValues)
            }
            else if to == .hsv {
                let intermediateValues = convert(values: inputValues, from: .hex, to: .srgb)
                return convert(values: intermediateValues, from: .srgb, to: .hsv)
            }
            else if to == .cmyk {
                let intermediateValues = convert(values: inputValues, from: .hex, to: .srgb)
                return convert(values: intermediateValues, from: .srgb, to: .cmyk)
            }
        }
        else if from == .cmyk {
            if to == .srgb {
                return cmykToSRGB(values: inputValues)
            }
            else if to == .hex {
                let intermediateValues = convert(values: inputValues, from: .cmyk, to: .srgb)
                return convert(values: intermediateValues, from: .srgb, to: .hex)
            }
            else if to == .hsv {
                let intermediateValues = convert(values: inputValues, from: .cmyk, to: .srgb)
                return convert(values: intermediateValues, from: .srgb, to: .hsv)
            }
        }
        return inputValues
    }
    
    // conversion base case helpers
    fileprivate static func copyInputs(values: [String], from: ZColor.ColorSpace) -> [String] {
        var inputValues : [String] = []
        
        // copy values to input array
        for value in values {
            inputValues.append(value)
        }
        
        // cap the array size based on the number of components relevant to the color space
        var arraySize = 3
        if from == .cmyk {
            arraySize = 4
        }
        else if from == .hex {
            arraySize = 1
        }
        
        // fix input array for number of color space values
        if inputValues.count < arraySize {
            for _ in 0 ... arraySize - inputValues.count {
                inputValues.append("0.0")
            }
        }
        else if inputValues.count > arraySize {
            inputValues = Array<String>(inputValues.prefix(arraySize))
        }
        
        return inputValues
    }
    
    fileprivate static func srgbToHsv(values: [String]) -> [String] {
        let rPrime = Double(values[0])! / 255.0
        let gPrime = Double(values[1])! / 255.0
        let bPrime = Double(values[2])! / 255.0
        
        let cMax = max(rPrime, gPrime, bPrime)
        let cMin = min(rPrime, gPrime, bPrime)
        let delta = cMax - cMin
        
        var hue = 0.0
        if cMax == rPrime {
            hue = 60.0 * (((gPrime - bPrime)/delta).truncatingRemainder(dividingBy: 6.0))
        }
        else if cMax == gPrime {
            hue = 60.0 * (((bPrime - rPrime)/delta) + 2)
        }
        else if cMax == bPrime {
            hue = 60.0 * (((rPrime - gPrime)/delta) + 4)
        }
        
        var saturation = 0.0
        if cMax != 0.0 {
            saturation = delta / cMax
        }
        
        return [String(hue), String(saturation * 100.0), String(cMax * 100.0)]
    }
    
    fileprivate static func srgbToCMYK(values: [String]) -> [String] {
        let rPrime = Double(values[0])! / 255.0
        let gPrime = Double(values[1])! / 255.0
        let bPrime = Double(values[2])! / 255.0
        
        let k = 1.0 - max(rPrime, gPrime, bPrime)
        let c = (1.0 - rPrime - k) / (1.0 - k)
        let m = (1.0 - gPrime - k) / (1.0 - k)
        let y = (1.0 - bPrime - k) / (1.0 - k)
        
        return [String(c * 100.0), String(m * 100.0), String(y * 100.0), String(k * 100.0)]
    }
    
    fileprivate static func hsvToSRGB(values: [String]) -> [String] {
        let h = Double(values[0])!
        let s = Double(values[1])!/100.0
        let v = Double(values[2])!/100.0
        
        let c = v * s
        let x = c * (1.0 - fabs((h / 60.0).truncatingRemainder(dividingBy: 2.0) - 1.0))
        let m = v - c
        
        var preOutputValues : [Double] = []
        if h < 60 {
            preOutputValues = [c, x, 0.0]
        }
        else if h >= 60.0 && h < 120.0 {
            preOutputValues = [x, c, 0.0]
        }
        else if h >= 120.0 && h < 180.0 {
            preOutputValues = [0.0, c, x]
        }
        else if h >= 180.0 && h < 240.0 {
            preOutputValues = [0.0, x, c]
        }
        else if h >= 240.0 && h < 300.0 {
            preOutputValues = [x, 0.0, c]
        }
        else if h >= 300.0 && h < 360.0 {
            preOutputValues = [c, 0.0, x]
        }
        
        let rPrime = preOutputValues[0]
        let gPrime = preOutputValues[1]
        let bPrime = preOutputValues[2]
        
        return [String((rPrime + m) * 255.0), String((gPrime + m) * 255.0), String((bPrime + m) * 255.0)]
    }
    
    fileprivate static func hexToSRGB(values: [String]) -> [String] {
        var cleanString = ZColor.cleanHexString(hexString: values[0])
        
        // check length, if not exactly a full length of 6, then...
        if cleanString.count < 6 {
            // ...append zeroes to make it full length
            for _ in 0 ... (6 - cleanString.count) {
                cleanString = cleanString + "0"
            }
        }
        else if values[0].count > 6 {
            // ...or, truncate everything but the first 6 characters
            cleanString = String(cleanString.prefix(6))
        }
        
        // separate hex values for each color variable
        var rHex = ""
        var gHex = ""
        var bHex = ""
        
        rHex.append(String(cleanString.removeFirst()))
        rHex.append(String(cleanString.removeFirst()))
        gHex.append(String(cleanString.removeFirst()))
        gHex.append(String(cleanString.removeFirst()))
        bHex.append(String(cleanString.removeFirst()))
        bHex.append(String(cleanString.removeFirst()))
        
        return [String(Int(rHex, radix: 16)!), String(Int(gHex, radix: 16)!), String(Int(bHex, radix: 16)!)]
    }
    
    fileprivate static func cmykToSRGB(values: [String]) -> [String] {
        let r = 255.0 * (1.0 - (Double(values[0])! / 100.0)) * (1.0 - (Double(values[3])! / 100.0))
        let g = 255.0 * (1.0 - (Double(values[1])! / 100.0)) * (1.0 - (Double(values[3])! / 100.0))
        let b = 255.0 * (1.0 - (Double(values[2])! / 100.0)) * (1.0 - (Double(values[3])! / 100.0))
        
        return [String(r), String(g), String(b)]
    }

    // auxiliary functions
    fileprivate static func cleanHexString(hexString: String) -> String {
        var searchString = hexString
        var cleanedString = ""
        let validChars = ["a", "b", "c", "d", "e", "f"]
        
        while searchString.count != 0 {
            let char = searchString.removeFirst()
            if char.isNumber {
                cleanedString.append(char)
            }
            else if char.isLetter {
                if validChars.contains(char.lowercased()) {
                    cleanedString.append(char.lowercased())
                }
            }
        }
        
        return cleanedString
    }
}
