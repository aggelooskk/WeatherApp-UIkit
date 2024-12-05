//
//  WeeklyForecastDetailRow.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 12/11/24.
//

import UIKit

class WeeklyForecastDetailRow: UITableViewCell {
    static let id = "WeeklyForecastDetailRow"
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var lowLabel: UILabel!
    @IBOutlet private weak var highLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ forecast: DailyForecast) {
        dayLabel.text = forecast.day
        let low = forecast.lows.average()
        let high = forecast.highs.average()
        
        let lowInt = Int(low)
        let highInt = Int(high)
        lowLabel.text = "\(lowInt)°"
        highLabel.text = "\(highInt)°"
        
        slider.minimumValue = Float(low)
        slider.maximumValue = Float(high)
        let avg = forecast.average
        slider.value = Float(avg)
        
        if let description = forecast.description {
            let weather = WeatherType(description)
            img.image = weather.icon
        } else {
            img.image = nil
        }
    }
}
