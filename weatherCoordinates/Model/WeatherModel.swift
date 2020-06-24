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
    init(dictWeather: [String: Any]) {
        lat = dictWeather["lat"] as? Double
        lon = dictWeather["lon"] as? Double
        if let dictTemp = dictWeather["temp"] as? [String: Any] {
            temp = Temp(dictTemp: dictTemp)
        } else {
            temp = nil
        }
        
        if let dictVisibility = dictWeather["visibility"] as? [String: Any] {
            visibility = Visibility(dictVisibility: dictVisibility)
        } else {
            visibility = nil
        }
        
        if let dictHumidity = dictWeather["humidity"] as? [String: Any] {
            humidity = Humidity(dictHumidity: dictHumidity)
        } else {
            humidity = nil
        }
        
        if let dictFeelsLike = dictWeather["feels_like"] as? [String: Any] {
            feelsLike = FeelsLike(dictFeelsLike: dictFeelsLike)
        } else {
            feelsLike =  nil
        }
        
        if let dictWindSpeed = dictWeather["wind_speed"] as? [String: Any] {
            windSpeed = WindSpeed(dictWindSpeed: dictWindSpeed)
        } else {
            windSpeed = nil
        }
        
        if let dictWeatherCode = dictWeather["weather_code"] as? [String: Any] {
            weatherCode = WeatherCode(dictWeatherCode: dictWeatherCode)
        } else {
            weatherCode = nil
        }
        
        if let dictSunset = dictWeather["sunset"] as? [String: Any] {
            sunset = Sunset(dictSunset: dictSunset)
        } else {
            sunset = nil
        }
        
        if let dictObservationTime = dictWeather["observation_time"] as? [String: Any] {
            observationTime = ObservationTime(dictObservationTime: dictObservationTime)
        } else {
            observationTime = nil
        }
    }
        
    static func getWeathers(from value: Any) -> [WeatherModel]? {
        guard let value = value as? [[String: Any]] else { return nil }
        return value.compactMap {WeatherModel(dictWeather: $0) }
    }
}

struct Temp: Codable {
    let value: Int?
    let units: String?
    
    init(dictTemp: [String: Any]) {
        value = dictTemp["value"] as? Int
        units = dictTemp["units"] as? String
    }
}

struct FeelsLike: Codable {
    let value: Double?
    let units: String?
    init(dictFeelsLike: [String: Any]) {
        value = dictFeelsLike["value"] as? Double
        units = dictFeelsLike["units"] as? String
    }
    
}

struct WindSpeed: Codable {
    let value: Double?
    let units: String?
    init(dictWindSpeed: [String: Any]) {
        value = dictWindSpeed["value"] as? Double
        units = dictWindSpeed["units"] as? String
    }
}

struct Visibility: Codable {
    let value: Double?
    let units: String?
    init(dictVisibility: [String: Any]) {
        value = dictVisibility["value"] as? Double
        units = dictVisibility["units"] as? String
    }
}

struct Humidity: Codable {
    let value: Double?
    let units: String?
    init(dictHumidity: [String: Any]) {
        value = dictHumidity["value"] as? Double
        units = dictHumidity["units"] as? String
    }
    
}

struct Sunset: Codable {
    let value: String?
    init(dictSunset: [String: Any]) {
        value = dictSunset["value"] as? String
    }
}

struct  ObservationTime: Codable {
    let value: String?
    init(dictObservationTime: [String: Any]) {
        value = dictObservationTime["value"] as? String
    }
}

struct WeatherCode: Codable {
    let value: String?
    init(dictWeatherCode: [String: Any]) {
        value = dictWeatherCode["value"] as? String
    }
}
