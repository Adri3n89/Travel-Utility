//
//  NetworkError.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import Foundation

enum NetworkError: Error {
    case noData
    case badResponse
    case undecodableData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData: return NSLocalizedString("No Data, please check Internet", comment: "Network Error")
        case .badResponse: return NSLocalizedString("Bad response from API.", comment: "Network Error")
        case .undecodableData: return NSLocalizedString("Undecodable Datas, try again", comment: "Network Error")
        }
    }
}
