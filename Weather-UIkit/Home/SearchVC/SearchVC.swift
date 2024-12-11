//
//  SearchVC.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 7/12/24.
//

import UIKit

protocol SearchVCdelegate where Self: HomeVC {
    func didSelect(_ location: SearchLocation)
}

class SearchVC: UIViewController {
    
    weak var delegate: SearchVCdelegate?
    private let lm = LocationsManager.shared
    
    private var timer = Timer()
    
    private lazy var search: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsVC())
        search.searchBar.placeholder = "Search By City"
        search.obscuresBackgroundDuringPresentation = true
        search.hidesNavigationBarDuringPresentation = false
        search.searchResultsUpdater = self
        return search
    }()

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
          view.backgroundColor = .systemBackground
          navigationItem.searchController = search
          navigationItem.hidesSearchBarWhenScrolling = false
          setupUI()
          setupTableView()
      }
      
      private func setupUI() {
          view.addSubview(tableView)
          NSLayoutConstraint.activate([
              tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
              tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
              tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
              tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
          ])
      }
      
      private func setupTableView() {
          tableView.dataSource = self
          tableView.delegate = self
          tableView.register(LocationRow.self, forCellReuseIdentifier: LocationRow.searchId)
      }
  }

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let self else { return }
            
            timer.invalidate()
            let searchResults = searchController.searchResultsController as! SearchResultsVC
            searchResults.delegate = self
            searchResults.update(text: text)
            timer.invalidate()
        }
    }
}

  extension SearchVC: UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let locations = lm.getLocations()
          return locations.count
      }
    
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.resultsId, for: indexPath) as! LocationRow
              let locations = lm.getLocations()
              let location = locations[indexPath.row]
              cell.configure(location)
              return cell
              }
          }

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let locations = lm.getLocations()
            let location = locations[indexPath.row]
            lm.delete(location)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let locations = lm.getLocations()
        let location = locations[indexPath.row]
        delegate?.didSelect(location)
        lm.saveSelected(location)
            navigationController?.popViewController(animated: true)
    }
}
  
extension SearchVC: SearchResultsVCDelegate {
    func didSelect(_ location: SearchLocation) {
        lm.appendAndSave(location)
        let locations = lm.getLocations()
        let index = IndexPath(row: locations.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [index], with: .automatic)
        tableView.endUpdates()
        search.isActive = false
    }
}

