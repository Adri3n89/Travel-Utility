//
//  TravelUtilityURL.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 08/10/2021.
//

import Foundation

struct TravelUtilityURL {
    
    struct WeatherURL {
        static let current = "https://api.openweathermap.org/data/2.5/weather?"
        static let fiveDays = "http://api.openweathermap.org/data/2.5/forecast?"
        static let icons = "http://openweathermap.org/img/wn/"
    }
    
    struct TranslateURL {
        static let available = "https://translation.googleapis.com/language/translate/v2/languages?target=en&key="
        static let translate = "https://translation.googleapis.com/language/translate/v2?format=text&key="
    }
    
    struct ChangeURL {
        static let change = "http://data.fixer.io/api/latest?access_key="
        static let symbols = "http://data.fixer.io/api/symbols?access_key="
    }
    
}
