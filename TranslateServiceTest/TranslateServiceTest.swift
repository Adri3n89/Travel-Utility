//
//  TranslateServiceTest.swift
//  TranslateServiceTest
//
//  Created by Adrien PEREA on 02/10/2021.
//

@testable import Travel_Utility
import XCTest

class TranslateServiceTests: XCTestCase {

    // MARK: - TEST GetAvailableLanguages

    func testGetAvailableGivenDataAndGoodResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().availableCorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.getAvailableLanguages { error, languages in
            XCTAssertNil(error)
            XCTAssertNotNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetAvailableGivenNoDataAndError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let error = FakeResponseData().error

        TranslateURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.getAvailableLanguages { error, languages in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetAvailableGivenDataAndBadResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let jsonData = FakeResponseData().availableCorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.getAvailableLanguages { error, languages in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetAvailableGivenBadDataAndGoodResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.getAvailableLanguages { error, languages in
            XCTAssertEqual(error, .undecodableData)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    // MARK: - TEST translateDetect

    func testTranslateDetectGivenDataAndGoodResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().autoDetectCorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.translateDetect(text: "Bonjour", target: "en") { error, translation in
            XCTAssertNil(error)
            XCTAssertNotNil(translation)
            expectation.fulfill()
            XCTAssertEqual("Hello", translation)
        }
        wait(for: [expectation], timeout: 1)

    }
    
    func testTranslateDetectGivenNoDataAndError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let error = FakeResponseData().error

        TranslateURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.translateDetect(text: "Bonjour", target: "en") { error, languages in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }
    
    func testTranslateDetectGivenDataAndBadResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let jsonData = FakeResponseData().autoDetectCorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.translateDetect(text: "Bonjour", target: "en") { error, languages in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testTranslateDetectGivenBadDataAndGoodResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))
    
        translateService.translateDetect(text: "Bonjour", target: "en") { error, languages in
            XCTAssertEqual(error, .undecodableData)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    // MARK: - TEST translate

    func testTranslateGivenDataAndGoodResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().translateCorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.translate(text: "Bonjour", target: "en", source: "fr") { error, translation in
            XCTAssertNil(error)
            XCTAssertNotNil(translation)
            expectation.fulfill()
            XCTAssertEqual("Hello", translation)
        }
        wait(for: [expectation], timeout: 1)

    }

    func testTranslateGivenNoDataAndError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let error = FakeResponseData().error

        TranslateURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.translate(text: "Bonjour", target: "en", source: "fr") { error, languages in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testTranslateGivenDataAndBadResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let jsonData = FakeResponseData().translateCorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.translate(text: "Bonjour", target: "en", source: "fr") { error, languages in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testTranslateGivenBadDataAndGoodResponseAndNoError() {
        //given
        TranslateURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        TranslateURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TranslateURLProtocol.self]

        let translateService = TranslateService(urlSession: URLSession(configuration: configuration))

        translateService.translate(text: "Bonjour", target: "en", source: "fr") { error, languages in
            XCTAssertEqual(error, .undecodableData)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

}

// MARK: - Fake URLProtocol
final class TranslateURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse, Error?))?

    override func startLoading() {
        guard let handler = TranslateURLProtocol.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (data, response, error) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }

    override func stopLoading() {}
}
