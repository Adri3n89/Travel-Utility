//
//  WeatherServiceTest.swift
//  WeatherServiceTest
//
//  Created by Adrien PEREA on 02/10/2021.
//

@testable import Travel_Utility
import XCTest

class WeatherServiceTests: XCTestCase {

    // MARK: - TEST GetWeather

    func testGetWeatherGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().weatherCorrectData

        WeatherURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeather(city: "New+York", unit: "metric", language: "fr") { error, weather in
            XCTAssertNil(error)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetWeatherGivenNoDataAndError() {
        //given
        let response = FakeResponseData().reponseKO
        let error = FakeResponseData().error

        WeatherURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeather(city: "New+York", unit: "metric", language: "fr") { error, weather in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetWeatherGivenDataAndBadResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseKO
        let jsonData = FakeResponseData().weatherCorrectData

        WeatherURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeather(city: "New+York", unit: "metric", language: "fr") { error, weather in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetWeatherGivenBadDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        WeatherURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeather(city: "New+York", unit: "metric", language: "fr") { error, weather in
            XCTAssertEqual(error, .undecodableData)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    // MARK: - TEST GetWeather5Days

    func testGetWeather5DaysGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().weather5CorrectData

        WeatherURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeatherForFiveDays (city: "New+York", unit: "metric") { error, weather in
            XCTAssertNil(error)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetWeather5DaysGivenNoDataAndError() {
        //given
        let response = FakeResponseData().reponseKO
        let error = FakeResponseData().error

        WeatherURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeatherForFiveDays(city: "New+York", unit: "metric") { error, weather in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetWeather5DaysGivenDataAndBadResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseKO
        let jsonData = FakeResponseData().weatherCorrectData

        WeatherURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeatherForFiveDays(city: "New+York", unit: "metric") { error, weather in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetWeather5DaysGivenBadDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        WeatherURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getWeatherForFiveDays(city: "New+York", unit: "metric") { error, weather in
            XCTAssertEqual(error, .undecodableData)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    // MARK: - TEST GetIcon

    func testGetIconGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let iconData = FakeResponseData().iconData

        WeatherURLProtocol.loadingHandler = { request in
            return (iconData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getIcon(icon: "01d") { error, icon in
            XCTAssertNil(error)
            XCTAssertNotNil(icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetIconGivenGoodResponseAndError() {
        //given
        let response = FakeResponseData().reponseOK
        let error = FakeResponseData().error

        WeatherURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getIcon(icon: "01d") { error, icon in
            XCTAssertEqual(error, .noData)
            XCTAssertNil(icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetIconGivenDataAndBadResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseKO
        let iconData = FakeResponseData().iconData

        WeatherURLProtocol.loadingHandler = { request in
            return (iconData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [WeatherURLProtocol.self]

        let weatherService = WeatherService(urlSession: URLSession(configuration: configuration))

        weatherService.getIcon(icon: "01d") { error, icon in
            XCTAssertEqual(error, .badResponse)
            XCTAssertNil(icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

}

// MARK: - Fake URLProtocol
final class WeatherURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse, Error?))?

    override func startLoading() {
        guard let handler = WeatherURLProtocol.loadingHandler else {
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
