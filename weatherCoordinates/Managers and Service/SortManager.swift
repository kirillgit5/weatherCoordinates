//
//  SortManager.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 20.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class SortManager {
    static let shared = SortManager()
    
    private init() {}
    
    func sortWeatherDate(weathersData:  [WeatherModel]) -> [[WeatherModel]] {
        var weathers = weathersData
        var sortWeather = [[WeatherModel]]()
        while (!weathers.isEmpty) {
            guard let weather = weathers.first else {return sortWeather}
            if  let observationTime = weather.observationTime?.value ,
                let dateSort =  DateManager.shared.dateFormatFromIso8601(from: observationTime) ,
                let daySort = DateManager.shared.dateFormatCurrentDayFromIso8601(from: dateSort) {
                let weatherInOneDay = weathers.filter { (weather) -> Bool in
                    guard let observationTime = weather.observationTime?.value ,
                        let date =  DateManager.shared.dateFormatFromIso8601(from: observationTime) ,
                        let day = DateManager.shared.dateFormatCurrentDayFromIso8601(from: date) else {return false}
                    return day == daySort
                }
                weathers = weathers.filter{ (weather) -> Bool in
                    guard let observationTime = weather.observationTime?.value ,
                        let date =  DateManager.shared.dateFormatFromIso8601(from: observationTime) ,
                        let day = DateManager.shared.dateFormatCurrentDayFromIso8601(from: date) else {return false}
                    return day != daySort
                }
                sortWeather.append(weatherInOneDay)
                
            } else {
                weathers.removeFirst()
            }
        }
        return sortWeather
    }
    
}
