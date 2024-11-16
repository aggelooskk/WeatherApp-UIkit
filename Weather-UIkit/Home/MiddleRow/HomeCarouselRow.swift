//
//  HomeCarouselRow.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 10/11/24.
//

import UIKit

class HomeCarouselRow: UITableViewCell {
    static let id = "HomeCarouselRow"
    private var forecast: WeeklyForecast?

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configure(_ forecast: WeeklyForecast?) {
        guard let forecast else { return }
        self.forecast = forecast
        collectionView.reloadData()
    }

}

extension HomeCarouselRow: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyForecastCell.id, for: indexPath) as! DailyForecastCell
        if let list = forecast?.list {
            let item = list[indexPath.row]
            cell.configure(item)
        }
        return cell
    }
}

extension HomeCarouselRow: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 140)
    }
}
