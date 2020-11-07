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
    
    func testRegisterTableViewCell() {
        viewController.registerTableViewCell()
        
        let forecastTableViewCell = viewController.tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier)
        
        let forecastTableViewHeaderCell = viewController.tableView.dequeueReusableHeaderFooterView(withIdentifier: ForecastTableViewHeaderCell.identifier)
        
        XCTAssertNotNil(forecastTableViewCell)
        XCTAssertTrue(forecastTableViewCell is ForecastTableViewCell)
        
        XCTAssertNotNil(forecastTableViewHeaderCell)
        XCTAssertTrue(forecastTableViewHeaderCell is ForecastTableViewHeaderCell)
    }
    
    func testTableViewWithZeroSectionAndZeroRows() {
        viewController.forecastByDates = []
        viewController.tableView.reloadData()
        
        XCTAssertEqual(0, viewController.tableView.numberOfSections)
    }
    
    func testTableViewWithTwoSectionsAndRows() {
        viewController.forecastByDates = [
            ForecastViewModel.Forecast5Days.Forecast(
                date: "Tuesday, December 29",
                values: [
                    ForecastViewModel.Forecast5Days.Forecast.Value(
                            time: "14:00",
                            tempMaxMin: "27/25°C",
                            weathericonURL: "http://openweathermap.org/img/wn/10d@4x.png",
                            weatherDescription: "hevry rain"
                    ),
                    ForecastViewModel.Forecast5Days.Forecast.Value(
                            time: "17:00",
                            tempMaxMin: "28/22°C",
                            weathericonURL: "http://openweathermap.org/img/wn/6d@4x.png",
                            weatherDescription: "clear sun"
                    )
                ]
            ),
            ForecastViewModel.Forecast5Days.Forecast(
                date: "Wednesday, December 30",
                values: [
                    ForecastViewModel.Forecast5Days.Forecast.Value(
                            time: "09:00",
                            tempMaxMin: "35/34°C",
                            weathericonURL: "http://openweathermap.org/img/wn/2d@4x.png",
                            weatherDescription: "rain"
                    )
                ]
            )
        ]
        viewController.tableView.reloadData()
        
        XCTAssertEqual(2, viewController.tableView.numberOfSections)
        XCTAssertEqual(2, viewController.tableView.numberOfRows(inSection: 0))
        XCTAssertEqual(1, viewController.tableView.numberOfRows(inSection: 1))
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
