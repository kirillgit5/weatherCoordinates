//
//  SearchBetaControllerViewController.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 23.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
class SearchBetaControllerViewController: UIViewController {
   var resultsViewController: GMSAutocompleteResultsViewController?
     var searchController: UISearchController?
     var resultView: UITextView?

     override func viewDidLoad() {
       super.viewDidLoad()
        makeButton()
       resultsViewController = GMSAutocompleteResultsViewController()
       resultsViewController?.delegate = self

       searchController = UISearchController(searchResultsController: resultsViewController)
       searchController?.searchResultsUpdater = resultsViewController

       // Put the search bar in the navigation bar.
       searchController?.searchBar.sizeToFit()
       navigationItem.titleView = searchController?.searchBar

       // When UISearchController presents the results view, present it in
       // this view controller, not one further up the chain.
       definesPresentationContext = true

       // Prevent the navigation bar from being hidden when searching.
       searchController?.hidesNavigationBarDuringPresentation = false
     }
    @objc func autocompleteClicked(_ sender: UIButton) {
         let autocompleteController = GMSAutocompleteViewController()
         autocompleteController.delegate = self

         // Specify the place data types to return.
         let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
           UInt(GMSPlaceField.placeID.rawValue))!
         autocompleteController.placeFields = fields

         // Specify a filter.
         let filter = GMSAutocompleteFilter()
         filter.type = .address
         autocompleteController.autocompleteFilter = filter

         // Display the autocomplete view controller.
         present(autocompleteController, animated: true, completion: nil)
       }

       // Add a button to the view.
       func makeButton() {
         let btnLaunchAc = UIButton(frame: CGRect(x: 5, y: 150, width: 300, height: 35))
         btnLaunchAc.backgroundColor = .blue
         btnLaunchAc.setTitle("Launch autocomplete", for: .normal)
         btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
         self.view.addSubview(btnLaunchAc)
       }

     }


   // Handle the user's selection.
   extension SearchBetaControllerViewController: GMSAutocompleteResultsViewControllerDelegate {
     func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                            didAutocompleteWith place: GMSPlace) {
       searchController?.isActive = false
       // Do something with the selected place.
       print("Place name: \(place.name)")
       print("Place address: \(place.formattedAddress)")
       print("Place attributions: \(place.attributions)")
     }

     func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                            didFailAutocompleteWithError error: Error){
       // TODO: handle the error.
       print("Error: ", error.localizedDescription)
     }

     // Turn the network activity indicator on and off again.
     func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       UIApplication.shared.isNetworkActivityIndicatorVisible = true
     }

     func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       UIApplication.shared.isNetworkActivityIndicatorVisible = false
     }
   }

extension SearchBetaControllerViewController: GMSAutocompleteViewControllerDelegate {

// Handle the user's selection.
func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
  print("Place name: \(place.name)")
  print("Place ID: \(place.placeID)")
  print("Place attributions: \(place.attributions)")
  dismiss(animated: true, completion: nil)
}

func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
  // TODO: handle the error.
  print("Error: ", error.localizedDescription)
}

// User canceled the operation.
func wasCancelled(_ viewController: GMSAutocompleteViewController) {
  dismiss(animated: true, completion: nil)
}
}
