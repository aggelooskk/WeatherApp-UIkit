//
//  WeatherType.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 5/12/24.
//

import UIKit

enum WeatherType {
    case sunny, clear, cloudy, rainy, snowy, foggy, misty,  windy, none

    init(_ description: String) {
        switch description.lowercased() {
        case let str where str.contains("sun"):
            self = .sunny
        case let str where str.contains("clear"):
            self = .clear
        case let str where str.contains("cloud"):
            self = .cloudy
        case let str where str.contains("rain"):
            self = .rainy
        case let str where str.contains("wind"):
            self = .windy
        default:
            self = .none
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .rainy:
            return UIImage(systemName: "cloud.main.fill")
        case .sunny, .clear:
            return UIImage(systemName: "sun.max.fill")
        case .cloudy:
            return UIImage(systemName: "cloud.fill")
        case .snowy:
            return UIImage(systemName: "snowflake")
        case .foggy, .misty:
            return UIImage(systemName: "cloud.fog.fill")
        case .windy:
            return UIImage(systemName: "wind")
        case .none:
            return nil
        }
    }
}
