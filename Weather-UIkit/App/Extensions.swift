//
//  Extensions.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 16/11/24.
//

import Foundation

extension [Double] {
    func average() -> Double {
        var total: Double = 0
        var count: Double = 0
        for num in self {
            total += num
            count += 1
        }
        return total / count
    }
}
