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
                    dt: 1604858400,
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
                    dt: 1604869200,
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
                ),
                WeatherModel.GetForecast5Days.Response.Forecast(
                    dt: 1604955600,
                    main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                        temp: 36.23,
                        temp_min: 33.19,
                        temp_max: 42.54,
                        pressure: 230,
                        humidity: 350,
                        sea_level: 120,
                        grnd_level: 214,
                        temp_kf: 38.23
                    ),
                    weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                main: "Cloud 2",
                                description: "Clear cloud 2",
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
        
        XCTAssertEqual("Monday, November 9", viewController.viewModel?.forecastByDates?[0].date)
        XCTAssertEqual("01:00", viewController.viewModel?.forecastByDates?[0].values[0].time)
        XCTAssertEqual("39/37°C", viewController.viewModel?.forecastByDates?[0].values[0].tempMaxMin)
        XCTAssertEqual("Heavy Rain", viewController.viewModel?.forecastByDates?[0].values[0].weatherDescription)
        XCTAssertEqual("http://openweathermap.org/img/wn/11d@2x.png", viewController.viewModel?.forecastByDates?[0].values[0].weathericonURL)
        
        XCTAssertEqual("04:00", viewController.viewModel?.forecastByDates?[0].values[1].time)
        XCTAssertEqual("39/37°C", viewController.viewModel?.forecastByDates?[0].values[1].tempMaxMin)
        XCTAssertEqual("Clear Cloud", viewController.viewModel?.forecastByDates?[0].values[1].weatherDescription)
        XCTAssertEqual("http://openweathermap.org/img/wn/02n@2x.png", viewController.viewModel?.forecastByDates?[0].values[1].weathericonURL)
       
        XCTAssertEqual("Tuesday, November 10", viewController.viewModel?.forecastByDates?[1].date)
        XCTAssertEqual("04:00", viewController.viewModel?.forecastByDates?[1].values[0].time)
        XCTAssertEqual("43/33°C", viewController.viewModel?.forecastByDates?[1].values[0].tempMaxMin)
        XCTAssertEqual("Clear Cloud 2", viewController.viewModel?.forecastByDates?[1].values[0].weatherDescription)
        XCTAssertEqual("http://openweathermap.org/img/wn/02n@2x.png", viewController.viewModel?.forecastByDates?[1].values[0].weathericonURL)
    }
    
    func testGetForecast5DaysOnSuccessWithFahrenheit() {
        let response = WeatherModel.GetForecast5Days.Response(
            list: [
                WeatherModel.GetForecast5Days.Response.Forecast(
                    dt: 1604858400,
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
                    dt: 1604869200,
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
                ),
                WeatherModel.GetForecast5Days.Response.Forecast(
                    dt: 1604955600,
                    main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                        temp: 36.23,
                        temp_min: 33.19,
                        temp_max: 42.54,
                        pressure: 230,
                        humidity: 350,
                        sea_level: 120,
                        grnd_level: 214,
                        temp_kf: 38.23
                    ),
                    weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                main: "Cloud 2",
                                description: "Clear cloud 2",
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
        
        XCTAssertEqual("Monday, November 9", viewController.viewModel?.forecastByDates?[0].date)
        XCTAssertEqual("01:00", viewController.viewModel?.forecastByDates?[0].values[0].time)
        XCTAssertEqual("39/37°F", viewController.viewModel?.forecastByDates?[0].values[0].tempMaxMin)
        XCTAssertEqual("Heavy Rain", viewController.viewModel?.forecastByDates?[0].values[0].weatherDescription)
        XCTAssertEqual("http://openweathermap.org/img/wn/11d@2x.png", viewController.viewModel?.forecastByDates?[0].values[0].weathericonURL)
        
        XCTAssertEqual("04:00", viewController.viewModel?.forecastByDates?[0].values[1].time)
        XCTAssertEqual("39/37°F", viewController.viewModel?.forecastByDates?[0].values[1].tempMaxMin)
        XCTAssertEqual("Clear Cloud", viewController.viewModel?.forecastByDates?[0].values[1].weatherDescription)
        XCTAssertEqual("http://openweathermap.org/img/wn/02n@2x.png", viewController.viewModel?.forecastByDates?[0].values[1].weathericonURL)
       
        XCTAssertEqual("Tuesday, November 10", viewController.viewModel?.forecastByDates?[1].date)
        XCTAssertEqual("04:00", viewController.viewModel?.forecastByDates?[1].values[0].time)
        XCTAssertEqual("43/33°F", viewController.viewModel?.forecastByDates?[1].values[0].tempMaxMin)
        XCTAssertEqual("Clear Cloud 2", viewController.viewModel?.forecastByDates?[1].values[0].weatherDescription)
        XCTAssertEqual("http://openweathermap.org/img/wn/02n@2x.png", viewController.viewModel?.forecastByDates?[1].values[0].weathericonURL)
    }
    
    func testGetForecast5DaysOnError() {
        let networkError = NetworkError(code: "450", message: "what happen in here?", httpStatusCode: 500)
        presenter.getForecast5DaysOnError(error: networkError)
        
        XCTAssertFalse(viewController.isCalledGetForecast5DaysOnComplete)
        XCTAssertTrue(viewController.isCalledGetForecast5DaysOnError)
        
        XCTAssertEqual("Error code: 450\nMessage: what happen in here?", viewController.errorMessage)
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
