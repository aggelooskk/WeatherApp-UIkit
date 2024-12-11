//
//  SearchResultsVC.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 7/12/24.
//

import UIKit

protocol SearchResultsVCDelegate where Self: SearchVC {
    func didSelect(_ location: SearchLocation)
}

class SearchResultsVC: UIViewController {
    weak var delegate: SearchResultsVCDelegate?
    
    private var locations: [SearchLocation] = []
    
    private lazy var tableView: UITableView = {
          let table = UITableView()
        table.backgroundColor = .systemBackground
          table.showsHorizontalScrollIndicator = false
          table.showsVerticalScrollIndicator = false
          table.translatesAutoresizingMaskIntoConstraints = false
          return table
      }()
      

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationRow.self, forCellReuseIdentifier: LocationRow.resultsId)
    }
    
    func update(text: String) {
        print(text)
        Api.shared.fetchLocation(for: text) { [weak self] locations in
            guard let locations else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
            self.locations = locations
            self.tableView.reloadData()
            }
        }
    }
}

extension SearchResultsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
  
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.searchId, for: indexPath) as! LocationRow
            let location = locations[indexPath.row]
            cell.configure(location)
            return cell
            }
        }

extension SearchResultsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView,
     didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let location = locations[indexPath.row]
        delegate?.didSelect(location)
    }
}

