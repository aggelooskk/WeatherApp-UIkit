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
    
    private let appId = "6c97f874a9658c21efb0a5443d1be0bd&units=metric"
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
            return switch type {
            case is CurrentWeather.Type:
                "CurrentWeather"
            case is WeeklyForecast.Type:
                "WeeklyForecast"
            case is [SearchLocation].Type:
                "SearchLocation"
            default:
                ""
            }
        }
    
    // Live Data
    private func fetchSample<T: Decodable>(_ type: T.Type, _ request: URLRequest, completion: @escaping (T?) -> Void) {
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
    
    func fetchWeatherData(lat: Double, lon: Double, completion: @escaping((CurrentWeather?, WeeklyForecast?)) -> Void) {
       // call fetch x2 for currentweather and weeklyforecast objects
       // construct urlrequest object x2 for the fetch function
        guard let currentWeather = constructURL(for: .currrentWeather, lat, lon, nil),
        let weeklyForecast = constructURL(for: .currrentWeather, lat, lon, nil) else {
            completion((nil, nil))
            return
        }
    }
    
    func fetchSearchData(for city: String, completion: @escaping(SearchLocation?) -> Void) {
        // construct urlrequest object x1 for the fetch function for searching a location
        guard let search = constructURL(for: .citySearch, nil, nil, city) else {
            completion(nil)
            return
        }
    }
    
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping(CurrentWeather?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(appId)"
        let url = URL(string: urlStr)!
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(
                    CurrentWeather.self,
                    from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchForecast(lat: Double, lon: Double, completion: @escaping(WeeklyForecast?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(appId)"
        let url = URL(string: urlStr)!
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(
                    WeeklyForecast.self,
                    from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchLocation(for city: String, completion: @escaping([SearchLocation]?) -> Void) {
        let urlStr = "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=\(appId)"
        let url = URL(string: urlStr)!
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(
                    [SearchLocation].self,
                    from: data)
                completion(decodedData)
            } catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
}
