//
//  HomeWeeklyForecastRow.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 10/11/24.
//

import UIKit

class HomeWeeklyForecastRow: UITableViewCell {
    static let id = "HomeWeeklyForecastRow"
    private var dailyForecast: [DailyForecast] = []

    @IBOutlet weak var tableView: UITableView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configure(_ forecast: WeeklyForecast?) {
        guard let list = forecast?.list else { return }
        
    }
    private func getDailyForecasts(_ list: [WeeklyForecastList]) -> [DailyForecast] {
        var dailyForecasts: [DailyForecast] = []
        for item in list {
            guard let dt = item.dt,
                  let low = item.main?.tempMin,
                  let high = item.main?.tempMax  else { continue }
        }
        
        return dailyForecasts
    }

}

extension HomeWeeklyForecastRow: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyForecastDetailRow.id, for: indexPath) as! WeeklyForecastDetailRow
        return cell
    }
}

extension HomeWeeklyForecastRow: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
