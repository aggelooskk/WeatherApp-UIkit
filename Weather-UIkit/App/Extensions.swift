//
//  Extensions.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 16/11/24.
//

import UIKit

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

extension Int {
    func toDay() -> String {
        let date = Date(timeIntervalSince1970: Double(self))
        return date.formatted(Date.FormatStyle().weekday(.abbreviated))
    }
    
    func toHour() -> String {
        let formatter = DateFormatter()
        formatter
            .setLocalizedDateFormatFromTemplate("h:mm")
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        let date = Date(timeIntervalSince1970: Double(self))
        return formatter.string(from: date)
    }
}

extension [WeeklyForecastList] {
    func getDailyForecasts() -> [DailyForecast] {
        var dailyForecasts: [DailyForecast] = []
        for item in self {
            guard let dt = item.dt?.toDay(),
                  let low = item.main?.tempMin,
                  let high = item.main?.tempMax  else { continue }
            
            guard dailyForecasts.count > 0 else {
                let newDay = parse(using: item)
                dailyForecasts.append(newDay)
                continue
            }
            if dailyForecasts.last?.day == dt {
                let j = dailyForecasts.count - 1
                dailyForecasts[j].lows.append(low)
                dailyForecasts[j].highs.append(high)
            } else {
                let newDay = parse(using: item)
                dailyForecasts.append(newDay)
            }
        }
        return dailyForecasts
    }
    
    private func parse(using item: WeeklyForecastList) -> DailyForecast {
        var forecast = DailyForecast(
            day: item.dt!.toDay(),
            description: item.weather!.first?.main)
        forecast.lows.append(item.main!.tempMin!)
        forecast.highs.append(item.main!.tempMax!)
        return forecast
    }
}

extension UIColor {
    static let cloudColor = UIColor(named: "CloudyBackground")!
    static let raindColor = UIColor(named: "RainyBackground")!
    static let sunColor = UIColor(named: "SunnyBackground")!
    static let snowColor = UIColor(named: "SnoweyBackground")!
    static let winddColor = UIColor(named: "WindyBackground")!
}

extension UIViewController {
    func setBackgroundColor(_ weather: CurrentWeather?) {
        guard let description = weather?.weather.first?.main else {
            resetBackgroundColor()
            return
        }
        let weatherType = WeatherType(description)
        view.backgroundColor = weatherType.backgroundColor
        navigationController?.navigationBar.barTintColor = weatherType.backgroundColor
        tabBarController?.tabBar.barTintColor = weatherType.backgroundColor
    }
    
    func resetBackgroundColor() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barTintColor = .white
    }
}
