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
    
    func loadView() {
        _ = viewController.view
    }
}

class MockForecastInteractor: ForecastBusinessLogic {
    func getForecast5Days(cityName: String, weatherUnit: WeatherUnit) {
        
    }
}

class MockForecastRouter: ForecastRoutingLogic {
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
