//
//  BaseUITest.swift
//  weatherUITests
//
//  Created by Supanat on 7/11/2563 BE.
//

import Foundation
import XCTest

class BaseUITest: XCTestCase {
    
    let WAIT_TIMEOUT: TimeInterval = 3
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension XCUIElement {
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
