//
//  FakeResponseData.swift
//  WeatherServiceTest
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

class FakeResponseData {

    let reponseOK = HTTPURLResponse(url: URL(string: "http://validateproject9.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

    let reponseKO = HTTPURLResponse(url: URL(string: "http://validateproject9.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class WeatherError: Error {}
    let error = WeatherError()

    var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    var weather5CorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherFiveDays", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let incorrectData = "erreur".data(using: .utf8)

    let iconData = "icon".data(using: .utf8)

}
