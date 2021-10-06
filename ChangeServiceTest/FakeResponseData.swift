//
//  FakeResponseData.swift
//  ChangeServiceTest
//
//  Created by Adrien PEREA on 02/10/2021.
//


import Foundation

class FakeResponseData {

    let reponseOK = HTTPURLResponse(url: URL(string: "http://validateproject9.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

    let reponseKO = HTTPURLResponse(url: URL(string: "http://validateproject9.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class ChangeError: Error {}
    let error = ChangeError()

    var changeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Change", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    var symbolsCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Symbols", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let changeIncorrectData = "erreur".data(using: .utf8)!

}
