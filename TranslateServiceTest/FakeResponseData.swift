//
//  FakeResponseData.swift
//  TranslateServiceTest
//
//  Created by Adrien PEREA on 02/10/2021.
//


import Foundation

class FakeResponseData {

    let reponseOK = HTTPURLResponse(url: URL(string: "http://validateproject9.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

    let reponseKO = HTTPURLResponse(url: URL(string: "http://validateproject9.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class TranslateError: Error {}
    let error = TranslateError()

    var availableCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Available", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    var autoDetectCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "AutoTranslate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let incorrectData = "erreur".data(using: .utf8)!

}
