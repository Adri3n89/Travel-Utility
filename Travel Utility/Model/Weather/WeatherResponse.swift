//
//  WeatherResponse.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

// MARK: Weather Live Response
struct WeatherResponse: Decodable {
    var weather: [Weather]
    var main: Main
}

struct Weather: Decodable {
    var description: String
    var icon: String
}

struct Main: Decodable {
    var temp: Double
}

// MARK: Weather Live Response Formatted
struct WeatherInfo {
    var city = ""
    var system = ""
    var language = ""
    var unit = ""
}

// MARK: Weather 5 Days Response
struct WeatherResponseForFiveDays: Decodable {
    let cod: String
    let list: [List]
}

struct List: Decodable {
    let main: MainClass
    let weather: [Weather5Days]
    let dt_txt: String
}

struct MainClass: Decodable {
    let temp: Double
}

struct Weather5Days: Decodable {
    let icon: String
}

// MARK: Weather 5 Days Response Formatted
struct WeatherForFiveDaysInfo {
    var weather: [Info] = []
}

struct Info {
    var date: String
    var temp: Double
    var icon: String
}
