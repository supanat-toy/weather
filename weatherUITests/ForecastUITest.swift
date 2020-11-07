//
//  ForecastUITests.swift
//  weatherUITests
//
//  Created by Supanat on 7/11/2563 BE.
//

import XCTest

class ForecastUITest: BaseUITest {
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testBackToWeatherHomeView() {
        navigateToForecastView()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        let tempLabel = app.staticTexts["weather_temp_label"]
        if tempLabel.waitForExistence(timeout: WAIT_TIMEOUT) {
            XCTAssertTrue(tempLabel.exists)
        }
    }
    
    func testHeaderWeatherInfoEqualHeaderForecastInfo() {
        let weatherTempLabel = app.staticTexts["weather_temp_label"].label
        let weatherDescriptionLabel = app.staticTexts["weather_description_label"].label
        let weatherImageView = app.images["weather_icon_imageview"]
        XCTAssertTrue(weatherImageView.exists)
        
        navigateToForecastView()
        
        let forecastTempLabel = app.staticTexts["forecast_temp_label"].label
        let forecastDescriptionLabel = app.staticTexts["forecast_description_label"].label
        let forecastImageView = app.images["forecast_icon_imageview"]
        
        XCTAssertEqual(weatherTempLabel, forecastTempLabel)
        XCTAssertEqual(weatherDescriptionLabel, forecastDescriptionLabel)
        XCTAssertTrue(forecastImageView.exists)
    }
    
    func testTableViewExists() {
        navigateToForecastView()
        
        XCTAssertTrue(app.tables["forecast_tableview"].exists) 
    }
    
    private func navigateToForecastView() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        let tempLabel = app.staticTexts["forecast_temp_label"]
        if tempLabel.waitForExistence(timeout: WAIT_TIMEOUT) {
            XCTAssertTrue(tempLabel.exists)
        }
    }
}
