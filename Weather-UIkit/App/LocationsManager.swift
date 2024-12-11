//
//  LocationsManager.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 10/12/24.
//

import Foundation

class LocationsManager {
    static let shared = LocationsManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    private var locations: [SearchLocation] = []
    
    func getLocations() -> [SearchLocation] {
         if !locations.isEmpty {
             return locations
         } else {
             guard let data = defaults.object(forKey: "Locations") as? [Data] else { return [] }
             do {
                 let decoder = JSONDecoder()
                 for item in data {
                     let decodedData = try decoder.decode(
                         SearchLocation.self,
                         from: item)
                     locations.append(decodedData)
                 }
                 return locations
             } catch {
                 print(error)
                 return []
             }
         }
     }
     
     func appendAndSave(_ location: SearchLocation) {
         locations.append(location)
         saveLocation()
     }
    
    func delete(_ location: SearchLocation) {
         for i in 0..<locations.count {
             guard location == locations[i] else { continue }
             locations.remove(at: i)
             saveLocation()
             return
         }
     }
    
    private func saveLocation() {
        do {
            var encoded: [Data] = []
            let encoder = JSONEncoder()
            for location in locations {
                let data = try encoder.encode(location)
                encoded.append(data)
            }
            defaults.set(encoded, forKey: "Locations")
        } catch {
            print(error)
        }
    }
}
