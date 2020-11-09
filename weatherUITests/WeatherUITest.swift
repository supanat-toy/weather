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
    
    func testSearchEmptyCityName() {
        let cityTextField = app.textFields["city_text_field"]
        cityTextField.tap()
        cityTextField.clearAndEnterText(text: "")
        app.buttons["search_button"].tap()
        
        XCTAssertEqual(app.alerts.element.label, "Error")
    }
    
    func testCheckHandleValueWhenInvalidCityName() {
        let cityTextField = app.textFields["city_text_field"]
        cityTextField.tap()
        cityTextField.clearAndEnterText(text: "abc123")
        app.buttons["search_button"].tap()
        
        let alert = app.alerts["Error"]
        let button = alert.buttons["OK"]
        button.tap()
        
        let tempLabel = app.staticTexts["weather_temp_label"].label
        let weatherDescriptionLabel = app.staticTexts["weather_description_label"].label
        let weatherHumidityLabel = app.staticTexts["weather_humidity_label"].label
        let weatherPressureLabel = app.staticTexts["weather_pressure_label"].label
        let weatherWindLabel = app.staticTexts["weather_wind_label"].label
        let weatherCloudLabel = app.staticTexts["weather_cloud_label"].label
        
        XCTAssertEqual("N/A", tempLabel)
        XCTAssertEqual("N/A", weatherDescriptionLabel)
        
        XCTAssertEqual("N/A", weatherHumidityLabel)
        XCTAssertEqual("N/A", weatherPressureLabel)
        XCTAssertEqual("N/A", weatherWindLabel)
        XCTAssertEqual("N/A", weatherCloudLabel)
    }
    
    func testInvalidCityNameShouldCannotNavigateToForecast() {
        let cityTextField = app.textFields["city_text_field"]
        cityTextField.tap()
        cityTextField.clearAndEnterText(text: "abc123")
        app.buttons["search_button"].tap()
        
        let alert = app.alerts["Error"]
        let button = alert.buttons["OK"]
        button.tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        XCTAssertTrue(app.alerts["Error"].exists)
    }
}
