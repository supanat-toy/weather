//
//  ForecastInteractorTest.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class ForecastInteractorTest: XCTestCase {
    
    var interactor: ForecastInteractor!
    var presenter: MockForecastPresenter!
    
    override func setUp() {
        super.setUp()
        self.presenter = MockForecastPresenter()
    }
    
    func testGetWeatherOnSuccess() {
        self.interactor = ForecastInteractor(presenter: presenter,
                                             weatherWorker: MockWeatherWorkerSuccess())
        
        interactor.getForecast5Days(cityName: "Bangkok, TH", weatherUnit: .fahrenheit)
        
        XCTAssertTrue(presenter.isCalledGetForecastOnComplete)
        XCTAssertFalse(presenter.isCalledGetForecastOnError)
        XCTAssertNil(presenter.error)
        
        XCTAssertEqual(WeatherUnit.fahrenheit, presenter.weatherUnit)
        XCTAssertEqual(104323312, presenter.response?.list?[0].dt)
        XCTAssertEqual("Rain", presenter.response?.list?[0].weather?.first?.main)
        XCTAssertEqual("heavy rain", presenter.response?.list?[0].weather?.first?.description)
        XCTAssertEqual("11d", presenter.response?.list?[0].weather?.first?.icon)
        XCTAssertEqual(37.23, presenter.response?.list?[0].main?.temp)
        XCTAssertEqual(37.02, presenter.response?.list?[0].main?.temp_min)
        XCTAssertEqual(39.43, presenter.response?.list?[0].main?.temp_max)
        XCTAssertEqual(124, presenter.response?.list?[0].main?.pressure)
        XCTAssertEqual(300, presenter.response?.list?[0].main?.humidity)
        XCTAssertEqual(2.4, presenter.response?.list?[0].main?.sea_level)
        XCTAssertEqual(12.34, presenter.response?.list?[0].main?.grnd_level)
        XCTAssertEqual(38.33, presenter.response?.list?[0].main?.temp_kf)
        XCTAssertEqual(214, presenter.response?.list?[0].wind?.speed)
        XCTAssertEqual(104, presenter.response?.list?[0].wind?.deg)
        XCTAssertEqual(80, presenter.response?.list?[0].clouds?.all)
        
        XCTAssertEqual(104324342, presenter.response?.list?[1].dt)
        XCTAssertEqual("Cloud", presenter.response?.list?[1].weather?.first?.main)
        XCTAssertEqual("Clear cloud", presenter.response?.list?[1].weather?.first?.description)
        XCTAssertEqual("02n", presenter.response?.list?[1].weather?.first?.icon)
        XCTAssertEqual(37.23, presenter.response?.list?[1].main?.temp)
        XCTAssertEqual(37.19, presenter.response?.list?[1].main?.temp_min)
        XCTAssertEqual(38.54, presenter.response?.list?[1].main?.temp_max)
        XCTAssertEqual(230, presenter.response?.list?[1].main?.pressure)
        XCTAssertEqual(350, presenter.response?.list?[1].main?.humidity)
        XCTAssertEqual(120, presenter.response?.list?[1].main?.sea_level)
        XCTAssertEqual(214, presenter.response?.list?[1].main?.grnd_level)
        XCTAssertEqual(38.23, presenter.response?.list?[1].main?.temp_kf)
        XCTAssertEqual(1234, presenter.response?.list?[1].wind?.speed)
        XCTAssertEqual(21, presenter.response?.list?[1].wind?.deg)
        XCTAssertEqual(55, presenter.response?.list?[1].clouds?.all)
    }
    
    func testGetWeatherOnError() {
        self.interactor = ForecastInteractor(presenter: presenter,
                                             weatherWorker: MockWeatherWorkerError())
        interactor.getForecast5Days(cityName: "Bangkok, TH", weatherUnit: .celsius)
        
        XCTAssertTrue(presenter.isCalledGetForecastOnError)
        XCTAssertFalse(presenter.isCalledGetForecastOnComplete)
        XCTAssertEqual("Error-500", presenter.error?.code)
        XCTAssertEqual("Something is wrong!", presenter.error?.message)
        XCTAssertEqual(500, presenter.error?.httpStatusCode)
    }
}

class MockForecastPresenter: ForecastPresentationLogic {
    
    var response: WeatherModel.GetForecast5Days.Response?
    var weatherUnit: WeatherUnit?
    var isCalledGetForecastOnComplete = false
    
    var error: NetworkError?
    var isCalledGetForecastOnError = false
    
    func getForecast5DaysOnComplete(response: WeatherModel.GetForecast5Days.Response, weatherUnit: WeatherUnit) {
        self.response = response
        self.weatherUnit = weatherUnit
        self.isCalledGetForecastOnComplete = true
    }
    
    func getForecast5DaysOnError(error: NetworkError) {
        self.error = error
        self.isCalledGetForecastOnError = true
    }
}
