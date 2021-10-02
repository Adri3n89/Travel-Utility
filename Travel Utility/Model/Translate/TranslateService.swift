//
//  TranslateService.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

final class TranslateService {

    // MARK: - Private Variables

    private var task: URLSessionTask?
    private var urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    // MARK: - Methods

    func getAvailableLanguages(callback: @escaping (NetworkError?, [Langue]?) -> Void) {
        let urlString = "https://translation.googleapis.com/language/translate/v2/languages?key=\(translateKey)&target=en"
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
                guard let decodedResponse = try? JSONDecoder().decode(LanguageAvailable.self, from: data) else {
                    callback(.undecodableData, nil)
                    return
                }
                callback(nil, decodedResponse.data.languages)
            })
            task?.resume()
        }
    }

    func translateDetect(text: String, target: String, callback: @escaping (NetworkError?, String?) -> Void) {
        let urlbase = "https://translation.googleapis.com/language/translate/v2?key=\(translateKey)&format=text"
        let target = "&target=\(target)"
        let text = "&q=\(text)"
        let urlString = urlbase + text + target
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
                guard let decodedResponse = try? JSONDecoder().decode(AutoDetectResponse.self, from: data) else {
                    callback(.undecodableData, nil)
                    return
                }
                callback(nil, decodedResponse.data.translations[0].translatedText)
            })
            task?.resume()
        }
    }

   func translate(text: String, target: String, source: String, callback: @escaping (NetworkError?, String?) -> Void) {
       let urlbase = "https://translation.googleapis.com/language/translate/v2?key=\(translateKey)&format=text"
        let target = "&target=\(target)"
        let source = "&source=\(source)"
        let text = "&q=\(text)"
        let urlString = urlbase + target  + text + source
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
                guard let decodedResponse = try? JSONDecoder().decode(TranslatedResponse.self, from: data) else {
                    callback(.undecodableData, nil)
                    return
                }
                callback(nil, decodedResponse.data.translations[0].translatedText)
            })
            task?.resume()
        }
    }

}
