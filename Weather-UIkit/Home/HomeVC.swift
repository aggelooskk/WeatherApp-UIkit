//
//  ViewController.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 10/11/24.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTopRow.id, for: <#T##IndexPath#>) as! HomeTopRow
            return cell
        case 1:
           let cell = tableView.dequeueReusableCell(withIdentifier: HomeCarouselRow.id, for: <#T##IndexPath#>) as! HomeCarouselRow
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeWeeklyForecastRow.id, for: <#T##IndexPath#>) as! HomeWeeklyForecastRow
            return cell
        default:
           return UITableViewCell()
        }
    }
}

    extension HomeVC: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row{
            case 0:
                return 175
            case 1:
                return 125
            case 2:
                return 250
            default:
                return 0
        }
    }
}
