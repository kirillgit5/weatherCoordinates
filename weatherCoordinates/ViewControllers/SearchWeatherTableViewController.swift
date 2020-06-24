//
//  SearchWeatherTableViewController.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 23.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import IIDadata
class SearchWeatherTableViewController: UITableViewController {
        private let searchController = UISearchController(searchResultsController: nil)
        private var timer: Timer?
        private var suggestions : [AddressSuggestions]?
    private let autoCompleteFetcher = 
        
        // MARK: - Life Cycles Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
            setupSearchController()
        }
        
        
        // MARK: - Private Methods
        private func setupSearchController(){
            navigationItem.searchController = searchController
            navigationController?.navigationBar.prefersLargeTitles = true
            searchController.obscuresBackgroundDuringPresentation  = false
        }
        
        private func setupTableView(){
           
            tableView.rowHeight    = 50
        }
    
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let suggestions = suggestions else {return}
        let suggestion = suggestions[indexPath.row]
     searchController.isActive = false
    dismiss(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            guard let suggestions = suggestions else {return 0}
            return suggestions.count
        }
           
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = suggestions?[indexPath.row].value
         return cell
        }
    }
    
        


    // MARK: - Search Bar Delegate
    extension SearchWeatherTableViewController: UISearchBarDelegate {
         func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {[weak self] (_) in
                guard let self = self else { return }
                self.autoCompleteFetcher.fetchPlace(for: searchText) { (addressSuggestions) in
                    guard let returnSuggestions = addressSuggestions else { return }
                  //  print(returnSuggestions)
                    self.suggestions = returnSuggestions
                    self.weatherSearchTableView.reloadData()
                }
                
            })
        }
        
        func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
     }
    }

    // MARK: - Table View Delegate
   
