//
//    Location.swift
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

import CoreLocation
import SQLite3

/// Completion handler for reverse geocoding.
public typealias geocodeCompletionHandler = (_ placemark: CLPlacemark) -> ()

public extension CLGeocoder {
    /**
     Reverse geocodes a location directly into a placemark, wrapping error handling.
     
     - Parameter location: The location to be reverse geocoded.
     - Parameter completion: A closure specifying what should execute after the location has been successfully geocoded.
     */
    func quickReverseGeocode(_ location: CLLocation, _ completion: @escaping geocodeCompletionHandler) {
        self.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print("[ZerzuraKit] Quick geocode failed because of \(String(describing: error))")
            } else if let places = placemarks, let placemark = places.first {
                completion(placemark)
            }
        }
    }
}

/**
 An object used to decode addresses from CoreLocation data structures.
 
 ### Notes ###
 * Location Services must be enabled.
 * Properties are only refreshed when instantiated or calling update() with a new location.
*/
public class CLPersister {
    
    /**
     Initializes an empty CLPersister.
     
     - Parameter latitude: Latitude in degrees (positive for North and negative for South).
     - Parameter longitude: Longitude in degrees (negative for West and positive for East).
    */
    public init() {

    }
    
    // MARK: Store/Load
    // 0.8.2 methods for store and load
    fileprivate final var dbURL: URL?
    fileprivate final var dbConn: OpaquePointer?
    fileprivate final let dbFileName = "_zk.offlinestorage.clpersister.sqlite"
    fileprivate final let tableName = "CLPersister"
    fileprivate final var dbPrepared = false
    fileprivate final var dbError: String?
    
    fileprivate final func createDBFile() -> Bool {
        if dbURL == nil {
            do {
                dbURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(dbFileName)
            } catch {
                dbURL = nil
                return false
            }
        }
        return true
    }
    
    fileprivate final func prepareTable() -> Bool {
        if !dbPrepared {
            guard let _ = dbURL, let _ = dbConn else {
                return false
            }
            
            let createQuery = "CREATE TABLE IF NOT EXISTS " + tableName +
            """
            (
            id INTEGER PRIMARY KEY NOT NULL,
            lat DOUBLE,
            lon DOUBLE
            );
            """
            
            if sqlite3_exec(dbConn, createQuery, nil, nil, nil) != SQLITE_OK {
                dbError = String(cString: sqlite3_errmsg(dbConn)!)
                dbConn = nil
                return false
            } else {
                dbPrepared = true
            }
        }
        return true
    }
    
    fileprivate final func connect() -> Bool {
        if dbConn == nil {
            if sqlite3_open(self.dbURL?.path, &dbConn) != SQLITE_OK {
                dbError = String(cString: sqlite3_errmsg(dbConn)!)
                dbConn = nil
                return false
            }
        }
        return true
    }
    
    fileprivate final func dbReadyForQuery() -> Bool {
        if !createDBFile() {
            return false
        }
        if !connect() {
            return false
        }
        if !prepareTable() {
            return false
        }
        
        guard let _ = dbURL, let _ = dbConn else {
            return false
        }
        
        return true
    }
    
    /**
     Stores this CLPersister in device storage.
     */
    public final func store(_ location: CLLocation) -> Bool {
        if self.dbReadyForQuery() {
            let queryString =
            """
            INSERT INTO \(self.tableName) (id, lat, lon)
            VALUES (0, \(String(location.coordinate.latitude)), \(String(location.coordinate.longitude)))
            ON CONFLICT(id)
            DO UPDATE SET lat=\(String(location.coordinate.latitude)), lon=\(String(location.coordinate.longitude))
            """
            
            if sqlite3_exec(self.dbConn, queryString, nil, nil, nil) != SQLITE_OK {
                self.dbError = String(cString: sqlite3_errmsg(self.dbConn))
            } else {
                self.dbError = nil
            }
        }
        if dbError != nil {
            print("[CLPersister] Location could not be stored due to: \(error)")
            return false
        }
        return true
    }
    
    /**
     Updates this CLPersister with the most recently stored CLPersister.
     */
    public final func load() -> CLLocation? {
        var location: CLLocation?
        if self.dbReadyForQuery() {
            var sqlStatement: OpaquePointer?
            let queryString = "SELECT lat, lon FROM \(self.tableName) WHERE id='0'"
            
            if sqlite3_prepare(self.dbConn, queryString, -1, &sqlStatement, nil) != SQLITE_OK {
                self.dbError = String(cString: sqlite3_errmsg(self.dbConn)!)
                sqlite3_finalize(sqlStatement)
                return nil
            }
            while(sqlite3_step(sqlStatement) == SQLITE_ROW) {
                let latRaw = String(cString: sqlite3_column_text(sqlStatement,0))
                let lat = Double(latRaw) ?? 0.0
                let lonRaw = String(cString: sqlite3_column_text(sqlStatement,1))
                let lon = Double(lonRaw) ?? 0.0
                location = CLLocation(latitude: lat, longitude: lon)
            }
            sqlite3_finalize(sqlStatement)
        }
        return location
    }
}
