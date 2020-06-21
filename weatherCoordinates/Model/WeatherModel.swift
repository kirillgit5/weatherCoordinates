//
//  WeatherModel.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 19.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let lat:                Double?
    let lon:                Double?
    let temp:               Temp?
    let visibility:         Visibility?
    let humidity:           Humidity?
    let feelsLike:          FeelsLike?
    let windSpeed:          WindSpeed?
    let weatherCode:        WeatherCode?
    let sunset:             Sunset?
    let observationTime:    ObservationTime?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case temp
        case visibility
        case humidity
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case weatherCode = "weather_code"
        case sunset
        case observationTime = "observation_time"
        
    }
}

struct Temp: Codable {
    let value: Int?
    let units: String?
}

struct FeelsLike: Codable {
    let value: Double?
    let units: String?
}

struct WindSpeed: Codable {
    let value: Double?
    let units: String?
}

struct Visibility: Codable {
    let value: Double?
    let units: String?
}

struct Humidity: Codable {
    let value: Double?
    let units: String?
}

struct PrecipitationType: Codable {
    let value: String?
}

struct Sunset: Codable {
    let value: String?
}

struct  ObservationTime: Codable {
    let value: String?
}

struct WeatherCode: Codable {
    let value: String?
}
