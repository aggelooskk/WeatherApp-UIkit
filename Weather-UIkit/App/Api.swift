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
}
