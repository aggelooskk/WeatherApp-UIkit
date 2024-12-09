//
//  SearchLocation.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 9/12/24.
//

import Foundation

struct SearchLocation: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
