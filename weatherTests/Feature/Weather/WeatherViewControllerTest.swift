//
//  WeatherViewControllerTest.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class WeatherViewControllerTest: XCTestCase {
    
    var viewController: WeatherViewController!
    var mockInteractor: MockWeatherInteractor!
    var mockRouter: MockWeatherRouter!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "WeatherViewController") as? WeatherViewController
        
        mockInteractor = MockWeatherInteractor()
        mockRouter = MockWeatherRouter()
        
        viewController.interactor = mockInteractor
        viewController.router = mockRouter
        
        loadView()
    }
    
    func testForecastOnClickToCalledNavigateToForecastSegue() {
        viewController.forecastOnClick(UIBarButtonItem())
        XCTAssertTrue(mockRouter.isCalledNavigateToForecastSegue)
    }
    
    func testGetCurrentWeatherOnSuccess() {
        mockInteractor.clearData()
        
        viewController.cityTextField.text = "Bangkok, TH"
        viewController.weatherUnit = .fahrenheit
        
        viewController.getCurrentWeather()
        
        XCTAssertTrue(mockInteractor.isCalledGetCurrentWeather)
        XCTAssertEqual("Bangkok, TH", mockInteractor.cityName)
        XCTAssertEqual(.fahrenheit, mockInteractor.weatherUnit)
    }
    
    func testGetCurrentWeatherOnErrorWithInvalidCityTextField() {
        mockInteractor.clearData()
        
        viewController.cityTextField.text = nil
        viewController.weatherUnit = .fahrenheit
        
        viewController.getCurrentWeather()
        
        XCTAssertFalse(mockInteractor.isCalledGetCurrentWeather)
    }
    
    func testChangeWeatherUnitOnClick() {
        viewController.weatherUnit = .fahrenheit
        viewController.changeWeatherUnitOnClick(UIButton())
        
        XCTAssertEqual(.celsius, viewController.weatherUnit)
        XCTAssertTrue(mockInteractor.isCalledGetCurrentWeather)
        XCTAssertEqual(WeatherUnit.celsius.title, viewController.weatherUnitButton.titleLabel?.text)
        XCTAssertEqual(.celsius, mockInteractor.weatherUnit)
    }
    
    func testSearchOnClick() {
        viewController.cityTextField.text = "Roiet, TH"
        viewController.searchOnClick(UIButton())
        
        XCTAssertEqual(.celsius, viewController.weatherUnit)
        XCTAssertEqual("Roiet, TH", mockInteractor.cityName)
        XCTAssertTrue(mockInteractor.isCalledGetCurrentWeather)
    }
    
    func loadView() {
        _ = viewController.view
    }
}

class MockWeatherInteractor: WeatherBusinessLogic {
    
    var isCalledGetCurrentWeather = false
    var cityName: String?
    var weatherUnit: WeatherUnit?
    
    func getCurrentWeather(cityName: String, weatherUnit: WeatherUnit) {
        self.cityName = cityName
        self.weatherUnit = weatherUnit
        self.isCalledGetCurrentWeather = true
    }
    
    func clearData() {
        isCalledGetCurrentWeather = false
        cityName = nil
        weatherUnit = nil
    }
}

class MockWeatherRouter: WeatherRoutingLogic {
    
    var isCalledNavigateToForecastSegue = false
    
    func navigateToForecastSegue() {
        isCalledNavigateToForecastSegue = true
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
