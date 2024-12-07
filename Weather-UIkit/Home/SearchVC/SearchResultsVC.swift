//
//  SearchResultsVC.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 7/12/24.
//

import UIKit

class SearchResultsVC: UIViewController {
    
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
        tableView.register(LocationRow.self, forCellReuseIdentifier: LocationRow.id)
        
    }

}

extension SearchResultsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
  
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.id, for: indexPath) as! LocationRow
            return cell

            }
        }

extension SearchResultsVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 40
  }
}

