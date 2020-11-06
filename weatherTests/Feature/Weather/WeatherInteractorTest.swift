//
//  WeatherInteractorTest.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class WeatherInteractorTest: XCTest {
    
    var interactor: WeatherInteractor!
    var presenter: MockWeatherPresenter!
    
    override func setUp() {
        self.presenter = MockWeatherPresenter()
    }
    
    func testGetWeatherOnSuccess() {
        self.interactor = WeatherInteractor(presenter: presenter,
                                            weatherWorker: MockWeatherWorkerSuccess())
        
        interactor.getCurrentWeather(cityName: "Bangkok, TH", weatherUnit: .fahrenheit)
        
        XCTAssertTrue(presenter.isCalledGetWeatherOnComplete)
        XCTAssertFalse(presenter.isCalledGetWeatherOnError)
        XCTAssertNil(presenter.error)
        
        XCTAssertEqual(WeatherUnit.fahrenheit, presenter.weatherUnit)
        XCTAssertEqual("Bangkok", presenter.response?.name)
        XCTAssertEqual("cloud", presenter.response?.weather?.first?.main)
        XCTAssertEqual("clear cloud", presenter.response?.weather?.first?.description)
        XCTAssertEqual(38.21, presenter.response?.main?.temp)
        XCTAssertEqual(40.45, presenter.response?.main?.temp_max)
        XCTAssertEqual(24, presenter.response?.wind?.speed)
        XCTAssertEqual(140, presenter.response?.wind?.deg)
        XCTAssertEqual(70, presenter.response?.clouds?.all)
        XCTAssertEqual("TH", presenter.response?.sys?.country)
        XCTAssertEqual(10324233, presenter.response?.sys?.sunrise)
        XCTAssertEqual(10231232, presenter.response?.sys?.sunset)
    }
    
    func testGetWeatherOnError() {
        self.interactor = WeatherInteractor(presenter: presenter,
                                            weatherWorker: MockWeatherWorkerError())
        interactor.getCurrentWeather(cityName: "Bangkok, TH", weatherUnit: .celsius)
        
        XCTAssertTrue(presenter.isCalledGetWeatherOnError)
        XCTAssertFalse(presenter.isCalledGetWeatherOnComplete)
        XCTAssertNotNil(presenter.error)
    }
}

class MockWeatherPresenter: WeatherPresentationLogic {
    
    var response: WeatherModel.GetWeather.Response?
    var weatherUnit: WeatherUnit?
    var isCalledGetWeatherOnComplete = false
    
    var error: NetworkError?
    var isCalledGetWeatherOnError = false
    
    func getWeatherOnComplete(response: WeatherModel.GetWeather.Response, weatherUnit: WeatherUnit) {
        self.response = response
        self.weatherUnit = weatherUnit
        self.isCalledGetWeatherOnComplete = true
    }
    
    func getWeatherOnError(error: NetworkError) {
        self.error = error
        self.isCalledGetWeatherOnError = true
    }
}
