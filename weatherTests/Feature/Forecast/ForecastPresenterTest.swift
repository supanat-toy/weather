//
//  ForecastPresenterTest.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class ForecastPresenterTest: XCTestCase {
    
    var presenter: ForecastPresenter!
    var viewController: MockForecastViewController!
    
    override func setUp() {
        super.setUp()
        self.viewController = MockForecastViewController()
        self.presenter = ForecastPresenter(viewController: viewController)
    }
    
    func testGetForecast5DaysOnSuccessWithCelsius() {
        let response = WeatherModel.GetForecast5Days.Response(
            list: [
                WeatherModel.GetForecast5Days.Response.Forecast(
                    dt: 104323312,
                    main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                        temp: 37.23,
                        temp_min: 37.02,
                        temp_max: 39.43,
                        pressure: 124,
                        humidity: 300,
                        sea_level: 2.4,
                        grnd_level: 12.34,
                        temp_kf: 38.33
                    ),
                    weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                main: "Rain",
                                description: "heavy rain",
                                icon: "11d")
                    ],
                    wind: WeatherModel.GetForecast5Days.Response.Forecast.Wind(
                        speed: 214,
                        deg: 104
                    ),
                    clouds: WeatherModel.GetForecast5Days.Response.Forecast.Cloud(all: 80)
                ),
                WeatherModel.GetForecast5Days.Response.Forecast(
                    dt: 104324342,
                    main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                        temp: 37.23,
                        temp_min: 37.19,
                        temp_max: 38.54,
                        pressure: 230,
                        humidity: 350,
                        sea_level: 120,
                        grnd_level: 214,
                        temp_kf: 38.23
                    ),
                    weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                main: "Cloud",
                                description: "Clear cloud",
                                icon: "02n")
                    ],
                    wind: WeatherModel.GetForecast5Days.Response.Forecast.Wind(
                        speed: 1234,
                        deg: 21
                    ),
                    clouds: WeatherModel.GetForecast5Days.Response.Forecast.Cloud(all: 55)
                )
            ])
        
        presenter.getForecast5DaysOnComplete(response: response, weatherUnit: .celsius)
        
        XCTAssertTrue(viewController.isCalledGetForecast5DaysOnComplete)
        XCTAssertFalse(viewController.isCalledGetForecast5DaysOnError)
        XCTAssertNil(viewController.errorMessage)
        
//        XCTAssertEqual("70%", viewController.viewModel?.cloud)
//        XCTAssertEqual("40%", viewController.viewModel?.humidity)
//        XCTAssertEqual("12 hPa", viewController.viewModel?.pressure)
//        XCTAssertEqual("38°F", viewController.viewModel?.temp)
//        XCTAssertEqual("clear cloud", viewController.viewModel?.weatherDescriotion)
//        XCTAssertEqual("http://openweathermap.org/img/wn/10d@4x.png", viewController.viewModel?.weathericonURL)
//        XCTAssertEqual("24.43 m/s NE", viewController.viewModel?.windSpeed)
        // TODO: 123 test
    }
    
    func testGetForecast5DaysOnSuccessWithFahrenheit() {
        let response = WeatherModel.GetForecast5Days.Response(
            list: [
                WeatherModel.GetForecast5Days.Response.Forecast(
                    dt: 104323312,
                    main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                        temp: 37.23,
                        temp_min: 37.02,
                        temp_max: 39.43,
                        pressure: 124,
                        humidity: 300,
                        sea_level: 2.4,
                        grnd_level: 12.34,
                        temp_kf: 38.33
                    ),
                    weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                main: "Rain",
                                description: "heavy rain",
                                icon: "11d")
                    ],
                    wind: WeatherModel.GetForecast5Days.Response.Forecast.Wind(
                        speed: 214,
                        deg: 104
                    ),
                    clouds: WeatherModel.GetForecast5Days.Response.Forecast.Cloud(all: 80)
                ),
                WeatherModel.GetForecast5Days.Response.Forecast(
                    dt: 104324342,
                    main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                        temp: 37.23,
                        temp_min: 37.19,
                        temp_max: 38.54,
                        pressure: 230,
                        humidity: 350,
                        sea_level: 120,
                        grnd_level: 214,
                        temp_kf: 38.23
                    ),
                    weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                main: "Cloud",
                                description: "Clear cloud",
                                icon: "02n")
                    ],
                    wind: WeatherModel.GetForecast5Days.Response.Forecast.Wind(
                        speed: 1234,
                        deg: 21
                    ),
                    clouds: WeatherModel.GetForecast5Days.Response.Forecast.Cloud(all: 55)
                )
            ])
        
        presenter.getForecast5DaysOnComplete(response: response, weatherUnit: .fahrenheit)
        
        XCTAssertTrue(viewController.isCalledGetForecast5DaysOnComplete)
        XCTAssertFalse(viewController.isCalledGetForecast5DaysOnError)
        XCTAssertNil(viewController.errorMessage)
        
//        XCTAssertEqual("70%", viewController.viewModel?.cloud)
//        XCTAssertEqual("40%", viewController.viewModel?.humidity)
//        XCTAssertEqual("12 hPa", viewController.viewModel?.pressure)
//        XCTAssertEqual("38°F", viewController.viewModel?.temp)
//        XCTAssertEqual("clear cloud", viewController.viewModel?.weatherDescriotion)
//        XCTAssertEqual("http://openweathermap.org/img/wn/10d@4x.png", viewController.viewModel?.weathericonURL)
//        XCTAssertEqual("24.43 m/s NE", viewController.viewModel?.windSpeed)
    }
    
    func testGetForecast5DaysOnError() {
        let networkError = NetworkError(code: "450", message: "what happen in here?", httpStatusCode: 500)
        presenter.getForecast5DaysOnError(error: networkError)
        
        XCTAssertFalse(viewController.isCalledGetForecast5DaysOnComplete)
        XCTAssertTrue(viewController.isCalledGetForecast5DaysOnError)
        
        XCTAssertEqual("Error code: 450\nmessage: what happen in here?", viewController.errorMessage)
    }
}

class MockForecastViewController: ForecastDisplayLogic {
    
    var viewModel: ForecastViewModel.Forecast5Days?
    var isCalledGetForecast5DaysOnComplete = false
    
    var errorMessage: String?
    var isCalledGetForecast5DaysOnError = false
    
    func getForecast5DaysOnComplete(viewModel: ForecastViewModel.Forecast5Days) {
        self.viewModel = viewModel
        self.isCalledGetForecast5DaysOnComplete = true
    }
    
    func getForecast5DaysOnError(errorMessage: String) {
        self.errorMessage = errorMessage
        self.isCalledGetForecast5DaysOnError = true
    }
}
