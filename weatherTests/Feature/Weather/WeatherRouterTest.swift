//
//  WeatherRouterTest.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import XCTest
@testable import weather

class WeatherRouterTest: XCTestCase {
    
    var router: WeatherRouter!
    var mockViewController: MockViewController!
    
    override func setUp() {
        super.setUp()
        mockViewController = MockViewController()
        router = WeatherRouter(viewController: mockViewController)
    }
    
    func testNavigateToForecastSegueIdentifier() {
        router.navigateToForecastSegue()
        XCTAssertEqual("gotoForecastSegue", mockViewController.identifier)
    }

    func testPassingDataToDestinationViewController() {
        mockViewController.weatherDataStore = WeatherDataStore(
            cityName: "city name 1",
            weatherUnit: .celsius,
            temperature: "38°F",
            weatherDescription: "clear cloud",
            weatherImageURL: "http://openweathermap.org/img/wn/10d@4x.png"
        )
        
        let destinationView = ForecastViewController()
        destinationView.weatherDataStore = nil
        
        let segue = UIStoryboardSegue(identifier: "gotoForecastSegue", source: mockViewController, destination: destinationView)
        router.prepare(for: segue, sender: mockViewController)
        
        XCTAssertEqual("city name 1", destinationView.weatherDataStore?.cityName)
        XCTAssertEqual(.celsius, destinationView.weatherDataStore?.weatherUnit)
        XCTAssertEqual("38°F", destinationView.weatherDataStore?.temperature)
        XCTAssertEqual("clear cloud", destinationView.weatherDataStore?.weatherDescription)
        XCTAssertEqual("http://openweathermap.org/img/wn/10d@4x.png", destinationView.weatherDataStore?.weatherImageURL)
    }
}

class MockViewController: WeatherViewController {
    
    var identifier: String?
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        self.identifier = identifier
    }
}
