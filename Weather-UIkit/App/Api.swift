//
//  Api.swift
//  Weather-UIkit
//
//  Created by Anxhelo Kermezo on 12/11/24.
//

import Foundation

class Api {
    static let shared = Api()
    private init() {}
    
    private let appId = "6c97f874a9658c21efb0a5443d1be0bd"
    enum Endpoint: String {
        case currrentWeather = "/data/2.5/weather"
        case weeklyForecast = "/data/2.5/forecast"
        case citySearch = "/geo/1.0/direct"
    }
    
    func fetchSample<T: Decodable>(_ type: T.Type, completion: @escaping (T?) -> Void) {
            guard let path = Bundle.main.path(forResource: getResourceName(type), ofType: "json") else {
                completion(nil)
                return
            }
            let url = URL(filePath: path)
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try decoder.decode(
                    type,
                    from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
            }
        }
        
    private func getResourceName<T>(_ type: T.Type) -> String {
        switch type {
        case is CurrentWeather.Type:
            return "CurrentWeather"
        case is WeeklyForecast.Type:
            return "WeeklyForecast"
        case is [SearchLocation].Type:
            return "SearchLocation"
        default:
            return ""
        }
    }
    
    // Live Data
    private func fetch<T: Decodable>(_ type: T.Type, _ request: URLRequest, completion: @escaping (T?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(
                    type,
                    from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
           }
       }
        task.resume()
   }
    
    private func constructURL(for endpoint: Endpoint, _ lat: Double?, _ lon: Double?, _ city: String?) -> URLRequest? {
           var components = URLComponents()
           components.scheme = "https"
           components.host = "api.openweathermap.org"
           components.path = endpoint.rawValue
           switch endpoint {
           case .currrentWeather, .weeklyForecast:
               guard let lat, let lon else { return nil }
               components.queryItems = [
                   URLQueryItem(name: "lat", value: "\(lat)"),
                   URLQueryItem(name: "lon", value: "\(lon)"),
                   URLQueryItem(name: "units", value: "metric"),
                   URLQueryItem(name: "appid", value: appId)
               ]
           case .citySearch:
               guard let city else { return nil }
               components.queryItems = [
                   URLQueryItem(name: "q", value: city),
                   URLQueryItem(name: "limit", value: "\(10)"),
                   URLQueryItem(name: "appid", value: appId)
               ]
           }
           guard let url = components.url else { return nil }
           var request = URLRequest(
               url: url,
               cachePolicy: .useProtocolCachePolicy,
               timeoutInterval: 10)
           request.httpMethod = "GET"
           return request
       }
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping((CurrentWeather?, WeeklyForecast?)) -> Void) {
        guard let currentWeather = constructURL(for: .currrentWeather, lat, lon, nil),
              let weeklyForecast = constructURL(for: .weeklyForecast, lat, lon, nil) else {
            completion((nil, nil))
            return
        }
        
        var weather: CurrentWeather?
        var forecast: WeeklyForecast?
        
        let group = DispatchGroup()
        
        group.enter()
        fetch(CurrentWeather.self, currentWeather) { result in
            weather = result
            group.leave()
        }
        
        group.enter()
        fetch(WeeklyForecast.self, weeklyForecast) { result in
            forecast = result
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion((weather, forecast))
        }
    }
    
    func fetchLocation(city: String, completion: @escaping([SearchLocation]?) -> Void) {
        guard let search = constructURL(for: .citySearch, nil, nil, city) else {
            completion(nil)
            return
        }
        fetch([SearchLocation].self, search) { result in
            completion(result)
        }
    }
}
