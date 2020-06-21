//
//  WeatherCollectionViewCell.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 21.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "WeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
    }
    
    //MARK : - IB Outlets
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var weatherImageView : UIImageView!
    @IBOutlet var temperatuerValue : UILabel!
    
    //MARK : - Public Property
    public func configure(with weather: WeatherModel ) {
        if  let temp = weather.temp?.value ,  let units = weather.temp?.units {
            temperatuerValue.text = "\(temp) \(units)"
        } else {
            temperatuerValue.text = " None"
        }
        let weatherCode = weather.weatherCode?.value ?? "default"
        guard let image = UIImage(named: weatherCode) else {return}
        weatherImageView.image = image
        if let observationTime = weather.observationTime?.value ,
            let date =  DateManager.shared.dateFormatFromIso8601(from: observationTime) ,
            let time = DateManager.shared.dateFormatCurrentHourFromIso8601(from: date) {
            timeLabel.text = "\(time)"
        } else {
            timeLabel.text = "None"
        }
    }
    
}
