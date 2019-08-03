//
//  Misc.swift
//  ZerzuraKit
//
//  Created by Victor Li on 2019/8/2.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import Foundation

/**
 A temperature object used to represent a temperature across multiple temperature scales.
*/
public class ZTemp {
    /// Stored temperature in Kelvin.
    public private(set) var kelvin : Double = 273.15
    /// Stored temperature in Celsius.
    public private(set) var celsius : Double = 0.0
    /// Stored temperature in Fahrenheit.
    public private(set) var fahrenheit : Double = 32.0
    
    /**
     Used as a parameter to identify a temperature scale.
  
     ````
     case fahrenheit
     case celsius
     case kelvin
     ````
    */
    public enum TempScale {
        case fahrenheit
        case celsius
        case kelvin
    }
    
    /**
     Instantiates a ZTemp from a temperature value given in Fahrenheit.
     
     - Parameter fahrenheit: A Double representing the desired temperature in Fahrenheit.
     */
    public init(fahrenheit: Double) {
        self.set(fahrenheit: fahrenheit)
    }
    
    /**
     Instantiates a ZTemp from a temperature value given in Celsius.
     
     - Parameter celsius: A Double representing the desired temperature in Celsius.
     */
    public init(celsius: Double) {
        self.set(celsius: celsius)
    }
    
    /**
     Instantiates a ZTemp from a temperature value given in Kelvin.
     
     - Parameter kelvin: A Double representing the desired temperature in Kelvin.
     */
    public init(kelvin: Double) {
        self.set(kelvin: kelvin)
    }
    
    /**
     Sets a ZTemp's temperature values from a temperature value given in Fahrenheit.
     
     - Parameter fahrenheit: A Double representing the desired temperature in Fahrenheit.
    */
    public func set(fahrenheit: Double) {
        self.fahrenheit = fahrenheit
        self.celsius = ZTemp.convert(value: self.kelvin, from: .kelvin, to: .celsius)
        self.kelvin = ZTemp.convert(value: fahrenheit, from: .fahrenheit, to: .kelvin)
    }
    
    /**
     Sets a ZTemp's temperature values from a temperature value given in Celsius.
     
     - Parameter celsius: A Double representing the desired temperature in Celsius.
    */
    public func set(celsius: Double) {
        self.fahrenheit = ZTemp.convert(value: self.kelvin, from: .kelvin, to: .fahrenheit)
        self.celsius = celsius
        self.kelvin = ZTemp.convert(value: celsius, from: .celsius, to: .kelvin)
    }
    
    /**
     Sets a ZTemp's temperature values from a temperature value given in Kelvin.
     
     - Parameter kelvin: A Double representing the desired temperature in Kelvin.
    */
    public func set(kelvin: Double) {
        self.fahrenheit = ZTemp.convert(value: self.kelvin, from: .kelvin, to: .fahrenheit)
        self.celsius = ZTemp.convert(value: self.kelvin, from: .kelvin, to: .celsius)
        self.kelvin = kelvin
    }
    
    /**
     Converts a Double temperature value from one temperature scale to another.
     
     - Parameter value: The numeric temperature value to be converted.
     - Parameter from: A ZTemp.TempScale value representing the temperature scale of the supplied value.
     - Parameter to: A ZTemp.TempScale value representing the temperature scale to be converted to.
     
     - Returns: A Double representing the converted temperature value.
     */
    public static func convert(value: Double, from: ZTemp.TempScale, to: ZTemp.TempScale) -> Double {
        if from == .kelvin {
            if to == .celsius {
                return value - 273.15
            }
            else if to == .fahrenheit {
                return (1.8 * (value - 273.15)) + 32
            }
        }
        else if from == .celsius {
            if to == .fahrenheit {
                return (value * 1.8) + 32
            }
            else if to == .kelvin {
                return value + 273.15
            }
        }
        else if from == .fahrenheit {
            if to == .celsius {
                return (value - 32) / 1.8
            }
            else if to == .kelvin {
                return ((value - 32) / 1.8) + 273.15
            }
        }
        return value
    }
    
    /**
     Converts a Double temperature value from one temperature scale to another.
     
     - Parameter value: The numeric temperature value to be converted.
     - Parameter from: A ZTemp.TempScale value representing the temperature scale of the supplied value.
     - Parameter to: A ZTemp.TempScale value representing the temperature scale to be converted to.
     
     - Returns: A String representing the converted temperature value.
     */
    public static func string(value: Double, from: ZTemp.TempScale, to: ZTemp.TempScale?) -> String {
        var tempResult = ""
        if to != nil {
            tempResult = String(ZTemp.convert(value: value, from: from, to: to!)) + "°"
        }
        else {
            tempResult = String(value)
        }
        
        switch to! {
            case .fahrenheit:
                return tempResult + "F"
            case .celsius:
                return tempResult + "C"
            case .kelvin:
                return tempResult + "K"
        }
    }
    
    /**
     Converts a Double temperature value into a String localized to the device's preferred locale.
     
     - Parameter value: The numeric temperature value to be converted.
     - Parameter from: A UnitTemperature value representing the temperature scale of the supplied value.
     
     - Returns: A String representing the localized temperature.
     */
    public static func localizedString(value: Double, from: UnitTemperature) -> String {
        let tempFormatter = MeasurementFormatter()
        let numFormatter = NumberFormatter()
        numFormatter.maximumFractionDigits = 1
        tempFormatter.locale = ZDevice.preferredLocale()
        tempFormatter.numberFormatter = numFormatter
        
        return String(tempFormatter.string(from: Measurement(value: value, unit: from)))
    }
}

/**
 An object that contains methods for numbers.
 */
public class ZNum {
    /**
     An object that contains methods for binary numbers.
     */
    public class binary {
        /**
         Pads a String with leading zeroes up to the given length.

         ### Usage Example ###
         ````
         let c = ZNum.binary.pad(binaryString: "00001", length: 10)
         print(c)       // 0000000001
         ````
         
         - Parameter binaryString: A String representing a binary number.
         - Parameter desiredLength: The desired overall length of the result.
         
         - Returns: A binary string padded from the front to the desired length.
         */
        
        public static func pad(binaryString: String, desiredLength: Int) -> String {
            var newString = binaryString
 
            if desiredLength > binaryString.count {
                for _ in 0 ... desiredLength {
                    newString = "0" + newString
                }
            }
            return newString
        }
    }
}
