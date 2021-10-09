//
//  WeatherService.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

final class WeatherService {

    // MARK: - Private Variables

    private var task: URLSessionTask?
    private var urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    // MARK: - Methods

    func getWeather(city:String, unit:String, language:String, callback: @escaping (NetworkError?, WeatherResponse?) -> Void) {
        let baseString = TravelUtilityURL.WeatherURL.current
        let apiKey = "appid=\(weatherKey)"
        let city = "&q=\(city)"
        let unit = "&units=\(unit)"
        let language = "&lang=\(language)"
        let urlString = "\(baseString)\(apiKey)\(city)\(unit)\(language)"
        if let url = URL(string: urlString) {
            task?.cancel()
            task = urlSession.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(.noData, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == Constantes.status else {
                        callback(.badResponse, nil)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                        callback(.undecodableData, nil)
                        return
                    }
                    callback(nil, decodedResponse)
                }
            }
            task?.resume()
        }
    }

    func getWeatherForFiveDays(city:String, unit:String, callback: @escaping (NetworkError?, WeatherForFiveDaysInfo?) -> Void) {
        let baseString = TravelUtilityURL.WeatherURL.fiveDays
        let apiKey = "appid=\(weatherKey)"
        let city = "&q=\(city)"
        let unit = "&units=\(unit)"
        let urlString = "\(baseString)\(apiKey)\(city)\(unit)"
        if let url = URL(string: urlString) {
            task?.cancel()
            task = urlSession.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(.noData, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == Constantes.status else {
                        callback(.badResponse, nil)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(WeatherResponseForFiveDays.self, from: data) else {
                        callback(.undecodableData, nil)
                        return
                    }
                    var weatherForFiveDaysInfo = WeatherForFiveDaysInfo()
                    for list in decodedResponse.list {
                        weatherForFiveDaysInfo.weather.append(Info(date: list.dt_txt, temp: list.main.temp, icon: list.weather[0].icon))
                    }
                    callback(nil, weatherForFiveDaysInfo)
                }
            }
            task?.resume()
        }
    }

    func getIcon(icon: String, callback:@escaping (NetworkError?, Data?) -> Void) {
        let baseString = TravelUtilityURL.WeatherURL.icons
        let iconString = "\(icon)@2x.png"
        let urlString = "\(baseString)\(iconString)"
        if let url = URL(string: urlString) {
            task?.cancel()
            task = urlSession.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(.noData, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == Constantes.status else {
                        callback(.badResponse, nil)
                        return
                    }
                    callback(nil, data)
                }
            }
            task?.resume()
        }
    }

}
