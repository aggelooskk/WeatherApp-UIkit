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
    
    func fetchCurrentWeather(completion: @escaping (CurrentWeather?) -> Void) {
        guard let path = Bundle.main.path(forResource: "CurrentWeather", ofType: "json") else {
            completion(nil)
            return
        }
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decoderData = try decoder.decode(CurrentWeather.self, from: data)
            completion(decoderData)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    func fetchCurrentWeatherLive(completion: @escaping(CurrentWeather?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=37.9838&lon=23.7275&appid=6c97f874a9658c21efb0a5443d1be0bd&units=metric"
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
}
