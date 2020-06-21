//
//  DataManager.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 20.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import CoreGraphics

class DataManager {
    static let shared = DataManager()
    private init() {}
    func getUrlString(lat: Double ,lon: Double ) -> String {
      "https://api.climacell.co/v3/weather/forecast/hourly?lat=\(lat)&lon=\(lon)&unit_system=si&fields=visibility&fields=humidity&fields=sunset&fields=weather_code&fields=sunrise&fields=temp&fields=feels_like&fields=wind_speed&apikey=VigBvOm3VjCr4dVUcYlvJXZgrL8zlhVy"
    }
}
