//
//  DailyForecast.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 16/11/24.
//

import UIKit

struct DailyForecast {
    let img: UIImage
    let day: String
    
    var lows: [Double] = []
    var highs: [Double] = []
    var average: Double {
        return (lows.average() + highs.average()) / 2
    }
}