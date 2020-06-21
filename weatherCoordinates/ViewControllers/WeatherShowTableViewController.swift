//
//  WeatherShowTableViewController.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 20.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class WeatherShowTableViewController: UITableViewController {
    
    //MARK : - IB Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK : - Private Property
    var weathers = [[WeatherModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        tableView.register(WeatherTableViewCell.nib(),
                           forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return weathers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: weathers[indexPath.section])
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let weatherDay = weathers[section].first else {return nil}
        guard let observationTime = weatherDay.observationTime?.value ,
            let date = DateManager.shared.dateFormatFromIso8601(from: observationTime),
            let sectionDate = DateManager.shared.dateFormatCurrentDateForSection(from: date) else {return nil}
        return sectionDate
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
    //MARK : - Public Methods
    func makeRequest(urlString: UrlString) {
        NetworkService.shared.networkfetch(with: urlString) {[weak self](weatherModels) in
            guard let self = self else {return}
            guard let weatherModels = weatherModels else {return}
            self.weathers = SortManager.shared.sortWeatherDate(weathersData: weatherModels)
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
            
        }
    }
}

