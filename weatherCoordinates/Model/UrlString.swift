//
//  UrlString.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 21.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct UrlString {
   private let lat: Double
   private let lon: Double
    var urlString: String {
        "https://api.climacell.co/v3/weather/forecast/hourly?lat=\(lat)&lon=\(lon)&unit_system=si&fields=visibility&fields=humidity&fields=sunset&fields=weather_code&fields=sunrise&fields=temp&fields=feels_like&fields=wind_speed&apikey=VigBvOm3VjCr4dVUcYlvJXZgrL8zlhVy"
    }
}
extension UrlString {
    static func fetchUrlString(lat: Double, lon: Double) -> UrlString {
        return UrlString(lat: lat, lon: lon)
    }
}
