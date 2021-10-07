//
//  ChangeService.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

final class ChangeService {

    // MARK: - Private Variables

    private var task: URLSessionTask?
    private var urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    // MARK: - Methods

    func getChange(callback: @escaping (NetworkError?, [Devise]?) -> Void) {
        let urlString = "http://data.fixer.io/api/latest?access_key=\(currencyKey)"
        if let url = URL(string: urlString) {
            task?.cancel()
            task = urlSession.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    callback(.noData, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.badResponse, nil)
                    return
                }
                guard let decodedResponse = try? JSONDecoder().decode(ChangeResponse.self, from: data) else {
                    callback(.undecodableData, nil)
                    return
                }
                var deviseArray: [Devise] = []
                for element in decodedResponse.rates {
                    deviseArray.append(Devise(name: element.key, value: element.value))
                }
                deviseArray = deviseArray.sorted { $0.name < $1.name }
                callback(nil, deviseArray)
            })
            task?.resume()
        }
    }

    func getSymbols(callback: @escaping (NetworkError?, [String:String]?) -> Void) {
        let urlString = "http://data.fixer.io/api/symbols?access_key=\(currencyKey)"
        if let url = URL(string: urlString) {
            task?.cancel()
            task = urlSession.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    callback(.noData, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.badResponse, nil)
                    return
                }
                guard let decodedResponse = try? JSONDecoder().decode(Symbol.self, from: data) else {
                    callback(.undecodableData, nil)
                    return
                }
                callback(nil, decodedResponse.symbols)
            })
            task?.resume()
        }
    }

    func convertDevise(number: Double, input:Double, output:Double) -> String {
        let result = number / input * output
        return String(decimalOrNot(result: result))
        
    }

    private func decimalOrNot(result: Double) -> String {
        var resultFormated = ""
        let decimal = NumberFormatter()
        decimal.minimumFractionDigits = 0
        decimal.maximumFractionDigits = 4
        resultFormated = decimal.string(from: NSNumber(value: result))!
        return resultFormated
    }

}
