//
//  ForecastViewControllerTest.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class ForecastViewControllerTest: XCTestCase {
    
    var viewController: ForecastViewController!
    var mockInteractor: MockForecastInteractor!
    var mockRouter: MockForecastRouter!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "ForecastViewController") as? ForecastViewController
        
        mockInteractor = MockForecastInteractor()
        mockRouter = MockForecastRouter()
        
        viewController.interactor = mockInteractor
        viewController.router = mockRouter
        
        loadView()
    }
    
    func testGetForecast5DaysOnSuccess() {
        mockInteractor.clearData()
        
        viewController.weatherDataStore = WeatherDataStore(
            cityName: "Bangkok, TH",
            weatherUnit: .fahrenheit,
            temperature: nil,
            weatherDescription: nil,
            weatherImageURL: nil
        )
        
        viewController.viewDidLoad()

        XCTAssertTrue(mockInteractor.isCalledGetForecast5Days)
        XCTAssertEqual("Bangkok, TH", mockInteractor.cityName)
        XCTAssertEqual(.fahrenheit, mockInteractor.weatherUnit)
    }
    
    func testGetForecast5DaysOnErrorWithInvalidCityName() {
        mockInteractor.clearData()
        
        viewController.weatherDataStore = WeatherDataStore(
            cityName: nil,
            weatherUnit: .fahrenheit,
            temperature: nil,
            weatherDescription: nil,
            weatherImageURL: nil
        )
        
        viewController.viewDidLoad()
        XCTAssertFalse(mockInteractor.isCalledGetForecast5Days)
    }
    
    func testGetForecast5DaysOnErrorWithInvalidWeatherUnit() {
        mockInteractor.clearData()
        
        viewController.weatherDataStore = WeatherDataStore(
            cityName: "Bangkok, TH",
            weatherUnit: nil,
            temperature: nil,
            weatherDescription: nil,
            weatherImageURL: nil
        )
        
        viewController.viewDidLoad()
        XCTAssertFalse(mockInteractor.isCalledGetForecast5Days)
    }
    
    func loadView() {
        _ = viewController.view
    }
}

class MockForecastInteractor: ForecastBusinessLogic {
    
    var isCalledGetForecast5Days = false
    var cityName: String?
    var weatherUnit: WeatherUnit?
    
    func getForecast5Days(cityName: String, weatherUnit: WeatherUnit) {
        self.cityName = cityName
        self.weatherUnit = weatherUnit
        isCalledGetForecast5Days = true
    }
    
    func clearData() {
        isCalledGetForecast5Days = false
        cityName = nil
        weatherUnit = nil
    }
}

class MockForecastRouter: ForecastRoutingLogic {
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
