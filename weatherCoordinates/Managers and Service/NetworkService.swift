//
//  NetworkService.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 19.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    private func  networkReqest( with url:URL,complition: @escaping(Result<Data,Error>)->()) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                complition(.success(data))
            }
        }.resume()
    }
    func networkfetch(with urlString: UrlString,complition: @escaping(([WeatherModel]?)->())) {
        guard let url = URL(string: urlString.urlString) else {return}
        networkReqest(with: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let weatherModels = try JSONDecoder().decode([WeatherModel].self, from: data)
                    complition(weatherModels)
                } catch {
                    complition(nil)
                }
            case .failure(_):
                complition(nil)
            }
        }
    }
}

