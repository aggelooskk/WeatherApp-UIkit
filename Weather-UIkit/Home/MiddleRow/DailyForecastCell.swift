//
//  DailyForecastCell.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 11/11/24.
//

import UIKit

class DailyForecastCell: UICollectionViewCell {
    static let id = "DailyForecastCell"
    
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func configure() {
        
    }
}
