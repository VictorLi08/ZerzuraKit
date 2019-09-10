//
//  ZColor.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/8/5.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Foundation
import Darwin

/**
 An object that stores and handles conversion of color and opacity (alpha value) data.
*/
class ZColor {
   /// The stored color value in hexidecimal.
   private(set) var hexString : String = "000000"
   /// The stored color's alpha (opacity) value.
   private(set) var a : Double = 1.0
   
   /// The stored color's red color component (sRGB).
   private(set) var r : Double = 0.0
   /// The stored color's green color component (sRGB).
   private(set) var g : Double = 0.0
   /// The stored color's blue color component (sRGB).
   private(set) var b : Double = 0.0
   /// The stored color's hue (HSV).
   private(set) var h : Double = 0.0
   /// The stored color's saturation (HSV).
   private(set) var s : Double = 0.0
   /// The stored color's value or lightness (HSV).
   private(set) var v : Double = 0.0
   /// The stored color's cyan color component (CMYK).
   private(set) var c : Double = 0.0
   /// The stored color's magenta color component (CMYK).
   private(set) var m : Double = 0.0
   /// The stored color's yellow color component (CMYK).
   private(set) var y : Double = 0.0
   /// The stored color's key color component (CMYK).
   private(set) var k : Double = 1.0
   
   /**
    All supported color spaces.
   */
   enum ColorSpace {
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
   init() {
       
   }
   
   /**
    Instantiates a ZColor using sRGB color components.
    
    - Parameter r: Red (0.0 to 255.0).
    - Parameter g: Green (0.0 to 255.0).
    - Parameter b: Blue (0.0 to 255.0).
    - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
   */
   init(r: Double, g: Double, b: Double, a: Double? = 0.0) {
       self.set(r: r, g: g, b: b, a: a)
   }
   
   /**
    Instantiates a ZColor using HSV/HSL color components.
    
    - Parameter h: Hue (0.0 to 360.0).
    - Parameter s: Saturation (0.0 to 100.0).
    - Parameter v: Value or Lightness (0.0 to 100.0).
    - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
   */
   init(h: Double, s: Double, v: Double, a: Double? = 0.0) {
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
   init(c: Double, m: Double, y: Double, k: Double, a: Double? = 0.0) {
       self.set(c: c, m: m, y: y, k: k, a: a)
   }
   
   /**
    Instantiates a ZColor using a hexidecimal color value.
    
    # Usage Example #
    ````
    let amber = ZColor(hexString: "FFBF00")
    ````
    
    - Parameter hexString: A string containing a hexidecimal color value without the pound sign. Case does not matter.
    - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
   */
   init(hexString: String, a: Double? = 0.0) {
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
   func set(r: Double, g: Double, b: Double, a: Double? = 0.0) {
       self.a = a!
       
       // SRGB
       self.r = r
       self.g = g
       self.b = b
       
       // HEX
       let hex = ZColor.convert(values: [String(r), String(g), String(b)], from: .srgb, to: .hex)
       guard let hs = hex.first else {
           return
       }
       self.hexString = hs
       
       // HSV
       let hsv = ZColor.convert(values: [String(r), String(g), String(b)], from: .srgb, to: .hsv)
       guard let h = Double(hsv[0]), let s = Double(hsv[1]), let v = Double(hsv[2]) else {
           return
       }
       self.h = h
       self.s = s
       self.v = v
       
       // CMYK
       let cmyk = ZColor.convert(values: [String(r), String(g), String(b)], from: .srgb, to: .cmyk)
       guard let c = Double(cmyk[0]), let m = Double(cmyk[1]), let y = Double(cmyk[2]), let k = Double(cmyk[3]) else {
           return
       }
       self.c = c
       self.m = m
       self.y = y
       self.k = k
   }
   
   /**
    Resets a ZColor using HSV/HSL color components.
    
    - Parameter h: Hue (0.0 to 360.0).
    - Parameter s: Saturation (0.0 to 100.0).
    - Parameter v: Value or Lightness (0.0 to 100.0).
    - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
   */
   func set(h: Double, s: Double, v: Double, a: Double? = 0.0) {
       self.a = a!
       
       // SRGB
       let rgb = ZColor.convert(values: [String(h), String(s), String(v)], from: .hsv, to: .srgb)
       guard let r = Double(rgb[0]), let g = Double(rgb[1]), let b = Double(rgb[2]) else {
           return
       }
       self.r = r
       self.g = g
       self.b = b
       
       // HEX
       let hex = ZColor.convert(values: [String(h), String(s), String(v)], from: .hsv, to: .hex)
       guard let hs = hex.first else {
           return
       }
       self.hexString = hs
       
       // HSV
       self.h = h
       self.s = s
       self.v = v
       
       // CMYK
       let cmyk = ZColor.convert(values: [String(h), String(s), String(v)], from: .hsv, to: .cmyk)
       guard let c = Double(cmyk[0]), let m = Double(cmyk[1]), let y = Double(cmyk[2]), let k = Double(cmyk[3]) else {
           return
       }
       self.c = c
       self.m = m
       self.y = y
       self.k = k
   }
   
   /**
    Resets a ZColor using CMYK color components.
    
    - Parameter c: Cyan (0.0 to 100.0).
    - Parameter m: Magenta (0.0 to 100.0).
    - Parameter y: Yellow (0.0 to 100.0).
    - Parameter k: Key (0.0 to 100.0).
    - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
   */
   func set(c: Double, m: Double, y: Double, k: Double, a: Double? = 0.0) {
       self.a = a!
       
       // SRGB
       let rgb = ZColor.convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .srgb)
       guard let r = Double(rgb[0]), let g = Double(rgb[1]), let b = Double(rgb[2]) else {
           return
       }
       self.r = r
       self.g = g
       self.b = b
       
       // HEX
       let hex = ZColor.convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .hex)
       guard let hs = hex.first else {
           return
       }
       self.hexString = hs
       
       // HSV
       let hsv = ZColor.convert(values: [String(c), String(m), String(y), String(k)], from: .cmyk, to: .hsv)
       guard let h = Double(hsv[0]), let s = Double(hsv[1]), let v = Double(hsv[2]) else {
           return
       }
       self.h = h
       self.s = s
       self.v = v
       
       // CMYK
       self.c = c
       self.m = m
       self.y = y
       self.k = k
   }
   
   /**
    Instantiates a ZColor using a hexidecimal color value.
    
    # Usage Example #
    ````
    let amber = ZColor(hexString: "FFBF00")
    ````
    
    - Parameter hexString: A string containing a hexidecimal color value without the pound sign. Case does not matter.
    - Parameter a: An optional alpha value (0.0 to 1.0). If none is provided, alpha defaults to 1.
   */
   func set(hexString: String, a: Double? = 0.0) {
       self.a = a!
       
       // SRGB
       let rgb = ZColor.convert(values: [hexString], from: .hex, to: .srgb)
       guard let r = Double(rgb[0]), let g = Double(rgb[1]), let b = Double(rgb[2]) else {
           return
       }
       self.r = r
       self.g = g
       self.b = b
       
       // HEX
       self.hexString = ZColor.cleanHexString(hexString: hexString)
       
       // HSV
       let hsv = ZColor.convert(values: [hexString], from: .hex, to: .hsv)
       guard let h = Double(hsv[0]), let s = Double(hsv[1]), let v = Double(hsv[2]) else {
           return
       }
       self.h = h
       self.s = s
       self.v = v
       
       // CMYK
       let cmyk = ZColor.convert(values: [hexString], from: .hex, to: .cmyk)
       guard let c = Double(cmyk[0]), let m = Double(cmyk[1]), let y = Double(cmyk[2]), let k = Double(cmyk[3]) else {
           return
       }
       self.c = c
       self.m = m
       self.y = y
       self.k = k
   }
   
   /**
    Tests for equality between two ZColor objects.
    
    - Returns: True or False if the two objects hold the same color.
   */
   static func ==(lhs: ZColor, rhs: ZColor) -> Bool {
       return (lhs.r == rhs.r) && (lhs.g == rhs.g) && (lhs.b == rhs.b) &&
           (lhs.h == rhs.h) && (lhs.s == rhs.s) && (lhs.v == rhs.v) &&
           (lhs.c == rhs.c) && (lhs.m == rhs.m) && (lhs.y == rhs.y) &&
           (lhs.k == rhs.k) && (lhs.hexString == rhs.hexString) && (lhs.a == rhs.a)
   }
   
   /**
    Converts color components from one color space to another.

    - Parameter values: A list of color component values in String format.
    - Parameter from: The color space of the provided color values.
    - Paraemter to: The color space to be converted to.

    - Returns: A list of color component values in String format.
   */
   static func convert(values: [String], from: ZColor.ColorSpace, to: ZColor.ColorSpace) -> [String] {
       let inputValues = self.copyInputs(values: values, from: from)
       
       // begin conversion
       switch from {
       case .srgb:
           if to == .hex {
               var hexString = ""
               for item in inputValues {
                   if let component = Int(item) {
                       hexString.append(String(format:"%02X", component).lowercased())
                   } else {
                       hexString.append("00")
                   }
               }
               return [hexString]
           } else if to == .hsv {
               return srgbToHsv(values: inputValues)
           } else if to == .cmyk {
               return srgbToCMYK(values: inputValues)
           }
       case .hsv:
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
       case .hex:
           if to == .srgb {
               return hexToSRGB(values: inputValues)
           } else if to == .hsv {
               let intermediateValues = convert(values: inputValues, from: .hex, to: .srgb)
               return convert(values: intermediateValues, from: .srgb, to: .hsv)
           } else if to == .cmyk {
               let intermediateValues = convert(values: inputValues, from: .hex, to: .srgb)
               return convert(values: intermediateValues, from: .srgb, to: .cmyk)
           }
       case .cmyk:
           if to == .srgb {
               return cmykToSRGB(values: inputValues)
           } else if to == .hex {
               let intermediateValues = convert(values: inputValues, from: .cmyk, to: .srgb)
               return convert(values: intermediateValues, from: .srgb, to: .hex)
           } else if to == .hsv {
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
       } else if from == .hex {
           arraySize = 1
       }
       
       // fix input array for number of color space values
       if inputValues.count < arraySize {
           for _ in 0 ... arraySize - inputValues.count {
               inputValues.append("0.0")
           }
       } else if inputValues.count > arraySize {
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
       } else if cMax == gPrime {
           hue = 60.0 * (((bPrime - rPrime)/delta) + 2)
       } else if cMax == bPrime {
           hue = 60.0 * (((rPrime - gPrime)/delta) + 4)
       }
       
       var saturation = 0.0
       if cMax != 0.0 {
           saturation = delta / cMax
       }
       
       return [String(hue), String(saturation * 100.0), String(cMax * 100.0)]
   }
   
   fileprivate static func srgbToCMYK(values: [String]) -> [String] {
       guard let rPrime = Double(values[0]), let gPrime = Double(values[1]), let bPrime = Double(values[2]) else {
           return values
       }
       
       let k = 1.0 - max(rPrime/255.0, gPrime/255.0, bPrime/255.0)
       let c = (1.0 - rPrime/255.0 - k) / (1.0 - k)
       let m = (1.0 - gPrime/255.0 - k) / (1.0 - k)
       let y = (1.0 - bPrime/255.0 - k) / (1.0 - k)
       
       return [String(c * 100.0), String(m * 100.0), String(y * 100.0), String(k * 100.0)]
   }
   
   fileprivate static func hsvToSRGB(values: [String]) -> [String] {
       guard let h = Double(values[0]), let s = Double(values[1]), let v = Double(values[2]) else {
           return values
       }
       
       let c = (v/100.0) * (s/100.0)
       let x = c * (1.0 - fabs((h / 60.0).truncatingRemainder(dividingBy: 2.0) - 1.0))
       let m = (v/100.0) - c
       
       var preOutputValues : [Double] = []
       if h < 60 {
           preOutputValues = [c, x, 0.0]
       } else if h >= 60.0 && h < 120.0 {
           preOutputValues = [x, c, 0.0]
       } else if h >= 120.0 && h < 180.0 {
           preOutputValues = [0.0, c, x]
       } else if h >= 180.0 && h < 240.0 {
           preOutputValues = [0.0, x, c]
       } else if h >= 240.0 && h < 300.0 {
           preOutputValues = [x, 0.0, c]
       } else if h >= 300.0 && h < 360.0 {
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
       } else if values[0].count > 6 {
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
       
       guard let r = Int(rHex, radix: 16), let g = Int(gHex, radix: 16), let b = Int(bHex, radix: 16) else {
           return values
       }
       return [String(r), String(g), String(b)]
   }
   
   fileprivate static func cmykToSRGB(values: [String]) -> [String] {
       guard let cRaw = Double(values[0]), let mRaw = Double(values[1]), let yRaw = Double(values[2]), let kRaw = Double(values[3]) else {
           return values
       }
           
       let r = 255.0 * (1.0 - (cRaw / 100.0)) * (1.0 - (kRaw / 100.0))
       let g = 255.0 * (1.0 - (mRaw / 100.0)) * (1.0 - (kRaw / 100.0))
       let b = 255.0 * (1.0 - (yRaw / 100.0)) * (1.0 - (kRaw / 100.0))
       
       return [String(r), String(g), String(b)]
   }

   // auxiliary methods
   fileprivate static func cleanHexString(hexString: String) -> String {
       var searchString = hexString
       var cleanedString = ""
       let validChars = ["a", "b", "c", "d", "e", "f"]
       
       while searchString.count != 0 {
           let char = searchString.removeFirst()
           if char.isNumber {
               cleanedString.append(char)
           } else if char.isLetter {
               if validChars.contains(char.lowercased()) {
                   cleanedString.append(char.lowercased())
               }
           }
       }
       
       return cleanedString
   }
}
