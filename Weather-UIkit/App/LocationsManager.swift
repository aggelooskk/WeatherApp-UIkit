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
        return locations
    }
    
    func appendAndSave(_ location: SearchLocation) {
        locations.append(location)
        saveLocation()
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
