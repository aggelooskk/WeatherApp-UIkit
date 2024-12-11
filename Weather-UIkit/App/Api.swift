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
    
    func fetchCurrentWeatherLive(completion: @escaping(CurrentWeather?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=37.9838&lon=23.7275&appid=\(appId)"
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
    
    func fetchLocation(for city: String, completion: @escaping([SearchLocation]?) -> Void) {
        let urlStr = "http://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=\(appId)"
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
