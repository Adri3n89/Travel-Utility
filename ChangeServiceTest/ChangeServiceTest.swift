//
//  ChangeServiceTest.swift
//  ChangeServiceTest
//
//  Created by Adrien PEREA on 02/10/2021.
//


@testable import Travel_Utility
import XCTest

class ChangeServiceTest: XCTestCase {

    // MARK: - TEST GetChange

    func testGetChangeGivenDataAndGoodResponseAndNoError() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().changeCorrectData

        ChangeURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getChange { error, devise in
            XCTAssertNil(error)
            XCTAssertNotNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetChangeGivenIncorrectDataAndGoodResponseAndNoError() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().changeIncorrectData

        ChangeURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getChange { error, devise in
            XCTAssertEqual(error, .undecodableData)
            XCTAssertNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetChangeGivenErrorAndBadResponse() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let error = FakeResponseData().error

        ChangeURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getChange { error, devise in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetChangeGivenBadResponse() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let jsonData = FakeResponseData().changeCorrectData

        ChangeURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getChange { error, devise in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    // MARK: - TEST GetSymbols

    func testGetSymbolsGivenDataAndGoodResponseAndNoError() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().symbolsCorrectData

        ChangeURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getSymbols { error, devise in
            XCTAssertNil(error)
            XCTAssertNotNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetSymbolsGivenIncorrectDataAndGoodResponseAndNoError() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().changeIncorrectData

        ChangeURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getSymbols { error, devise in
            XCTAssertEqual(error, .undecodableData)
            XCTAssertNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetSymbolsGivenErrorAndBadResponse() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let error = FakeResponseData().error

        ChangeURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getSymbols { error, devise in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetSymbolsGivenBadResponse() {
        //given
        ChangeURLProtocol.loadingHandler = nil
        let response = FakeResponseData().reponseKO
        let jsonData = FakeResponseData().changeCorrectData

        ChangeURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]

        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        changeService.getSymbols { error, devise in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    // MARK: - TEST ConvertDevise

    func testGiven2NumbersAndFormatThem() {
        // given
        let number = 12.2
        let input = 2.3493828
        let output = 3.1

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ChangeURLProtocol.self]
        let changeService = ChangeService(urlSession: URLSession(configuration: configuration))

        let result = changeService.convertDevise(number: number, input: input, output: output)
        XCTAssertEqual(result, "16.0978")
    }

}

// fake urlProtocol
final class ChangeURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse, Error?))?

    override func startLoading() {
        guard let handler = ChangeURLProtocol.loadingHandler else {
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
