//
//  WeatherPresenterTest.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class WeatherPresenterTest: XCTestCase {
    
    var presenter: WeatherPresenter!
    var viewController: MockWeatherViewController!
    
    override func setUp() {
        super.setUp()
        self.viewController = MockWeatherViewController()
        self.presenter = WeatherPresenter(viewController: viewController)
    }
    
    func testGetCurrentWeatherOnSuccessWithCelsius() {
        let response = WeatherModel.GetWeather.Response(
            timezone: 10324453,
            name: "Bangkok",
            weather: [WeatherModel.GetWeather.Response.Weather(
                        main: "cloud",
                        description: "clear cloud",
                        icon: "10d")
            ],
            main: WeatherModel.GetWeather.Response.Main(
                temp: 38.21,
                feels_like: 38.43,
                temp_min: 38.18,
                temp_max: 40.45,
                pressure: 12.4,
                humidity: 40
            ),
            wind: WeatherModel.GetWeather.Response.Wind(
                speed: 24.43,
                deg: 140
            ),
            clouds: WeatherModel.GetWeather.Response.Cloud(all: 70),
            sys: WeatherModel.GetWeather.Response.Sys(
                country: "TH",
                sunrise: 10324233,
                sunset: 10231232
            )
        )
        presenter.getWeatherOnComplete(response: response, weatherUnit: .celsius)
        
        XCTAssertTrue(viewController.isCalledGetCurrentWeatherOnComplete)
        XCTAssertFalse(viewController.isCalledGetCurrentWeatherOnError)
        XCTAssertNil(viewController.errorMessage)
        
        XCTAssertEqual("70%", viewController.viewModel?.cloud)
        XCTAssertEqual("40%", viewController.viewModel?.humidity)
        XCTAssertEqual("12 hPa", viewController.viewModel?.pressure)
        XCTAssertEqual("38°C", viewController.viewModel?.temp)
        XCTAssertEqual("clear cloud", viewController.viewModel?.weatherDescriotion)
        XCTAssertEqual("http://openweathermap.org/img/wn/10d@4x.png", viewController.viewModel?.weathericonURL)
        XCTAssertEqual("24.43 m/s NE", viewController.viewModel?.windSpeed)
    }
    
    func testGetCurrentWeatherOnSuccessWithFahrenheit() {
        let response = WeatherModel.GetWeather.Response(
            timezone: 10324453,
            name: "Bangkok",
            weather: [WeatherModel.GetWeather.Response.Weather(
                        main: "cloud",
                        description: "clear cloud",
                        icon: "10d")
            ],
            main: WeatherModel.GetWeather.Response.Main(
                temp: 38.21,
                feels_like: 38.43,
                temp_min: 38.18,
                temp_max: 40.45,
                pressure: 12.4,
                humidity: 40
            ),
            wind: WeatherModel.GetWeather.Response.Wind(
                speed: 24.43,
                deg: 140
            ),
            clouds: WeatherModel.GetWeather.Response.Cloud(all: 70),
            sys: WeatherModel.GetWeather.Response.Sys(
                country: "TH",
                sunrise: 10324233,
                sunset: 10231232
            )
        )
        presenter.getWeatherOnComplete(response: response, weatherUnit: .fahrenheit)
        
        XCTAssertTrue(viewController.isCalledGetCurrentWeatherOnComplete)
        XCTAssertFalse(viewController.isCalledGetCurrentWeatherOnError)
        XCTAssertNil(viewController.errorMessage)
        
        XCTAssertEqual("70%", viewController.viewModel?.cloud)
        XCTAssertEqual("40%", viewController.viewModel?.humidity)
        XCTAssertEqual("12 hPa", viewController.viewModel?.pressure)
        XCTAssertEqual("38°F", viewController.viewModel?.temp)
        XCTAssertEqual("clear cloud", viewController.viewModel?.weatherDescriotion)
        XCTAssertEqual("http://openweathermap.org/img/wn/10d@4x.png", viewController.viewModel?.weathericonURL)
        XCTAssertEqual("24.43 m/s NE", viewController.viewModel?.windSpeed)
    }
    
    func testGetCurrentWeatherOnError() {
        let networkError = NetworkError(code: "511", message: "something is wrong?", httpStatusCode: 500)
        presenter.getWeatherOnError(error: networkError)
        
        XCTAssertFalse(viewController.isCalledGetCurrentWeatherOnComplete)
        XCTAssertTrue(viewController.isCalledGetCurrentWeatherOnError)
        
        XCTAssertEqual("Error code: 511\nMessage: something is wrong?", viewController.errorMessage)
    }
}

class MockWeatherViewController: WeatherDisplayLogic {
    
    var viewModel: WeatherViewModel.Weather?
    var isCalledGetCurrentWeatherOnComplete = false
    
    var errorMessage: String?
    var isCalledGetCurrentWeatherOnError = false
    
    func getCurrentWeatherOnComplete(viewModel: WeatherViewModel.Weather) {
        self.viewModel = viewModel
        self.isCalledGetCurrentWeatherOnComplete = true
    }
    
    func getCurrentWeatherOnError(errorMessage: String) {
        self.errorMessage = errorMessage
        self.isCalledGetCurrentWeatherOnError = true
    }
}
