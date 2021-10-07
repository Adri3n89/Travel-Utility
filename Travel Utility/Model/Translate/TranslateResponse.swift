//
//  TranslateResponse.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

// MARK: Translation Response
struct TranslatedResponse: Decodable {
    var data: Translation
}

struct Translation: Decodable {
    var translations: [TranslatedText]
}

struct TranslatedText: Decodable {
    var translatedText: String
}

// MARK: AutoDetect Translation Response
struct AutoDetectResponse: Decodable {
    var data: Translation2
}

struct Translation2: Decodable {
    var translations: [TranslatedText2]
}

struct TranslatedText2: Decodable {
    var translatedText: String
    var detectedSourceLanguage: String
}


// MARK: Available Languages Response
struct LanguageAvailable: Decodable {
    var data: Languages
}

struct Languages: Decodable {
    var languages: [Langue]
}

struct Langue: Decodable {
    var language: String
    var name: String
}
