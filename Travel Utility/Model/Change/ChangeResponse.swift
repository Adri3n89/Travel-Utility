//
//  ChangeResponse.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

struct ChangeResponse: Decodable {
    var rates: [String:Double]
}

struct Devise {
    var name: String
    var value: Double
}

struct Symbol: Decodable {
    var symbols: [String:String]
}
