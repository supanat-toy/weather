//
//  weatherUITests.swift
//  weatherUITests
//
//  Created by Supanat on 2/11/2563 BE.
//

import XCTest

class WeatherUITest: BaseUITest {
    
    override func setUp() {
        super.setUp()
    }
    
    func testChangeWeatherUnitWithFahrenheit() {
        let tempLabel = app.staticTexts["weather_temp_label"]
        app.buttons["change_weather_unit_button"].tap()
        
        if tempLabel.waitForExistence(timeout: WAIT_TIMEOUT) {
            XCTAssertEqual("F", tempLabel.label.last)
        }
    }
    
    func testChangeWeatherUnitWithCelsius() {
        let tempLabel = app.staticTexts["weather_temp_label"]
        XCTAssertEqual("C", tempLabel.label.last)
        app.buttons["change_weather_unit_button"].tap()
        
        if tempLabel.waitForExistence(timeout: WAIT_TIMEOUT) {
            app.buttons["change_weather_unit_button"].tap()
            
            if tempLabel.waitForExistence(timeout: WAIT_TIMEOUT) {
                XCTAssertEqual("C", tempLabel.label.last)
            }
        }
    }
    
    func testSearchCityName() {
        let tempLabel = app.staticTexts["weather_temp_label"]
        let cityTextField = app.textFields["city_text_field"]
        cityTextField.tap()
        cityTextField.clearAndEnterText(text: "Sathon, TH")
        app.buttons["search_button"].tap()
        
        if tempLabel.waitForExistence(timeout: WAIT_TIMEOUT) {
            XCTAssertTrue(tempLabel.exists)
        }
    }
    
    func testNavigateToForecastView() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        let tempLabel = app.staticTexts["forecast_temp_label"]
        if tempLabel.waitForExistence(timeout: WAIT_TIMEOUT) {
            XCTAssertTrue(tempLabel.exists)
        }
    }
}
