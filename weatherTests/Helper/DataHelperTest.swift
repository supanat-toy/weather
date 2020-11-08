//
//  DataHelperTest.swift
//  weatherTests
//
//  Created by Supanat on 7/11/2563 BE.
//

import Foundation
import XCTest
@testable import weather

class DataHelperTest: XCTestCase {
    
    var dataHelper: DataHelper!
    
    override func setUp() {
        super.setUp()
        
        dataHelper = DataHelper.shared
    }
    
    func testFormattNumberDecimalWithPointHalfDown() {
        let result = dataHelper.formattNumberDecimal(number: 12.431234, point: 2)
        XCTAssertEqual("12.43", result)
    }
    
    func testFormattNumberDecimalWithPointHalfUp() {
        let result = dataHelper.formattNumberDecimal(number: 12.43999, point: 2)
        XCTAssertEqual("12.44", result)
    }
    
    func testFormattNumberDecimalWithSecondPointIsZero() {
        let result = dataHelper.formattNumberDecimal(number: 12.4, point: 2)
        XCTAssertEqual("12.40", result)
    }
    
    func testFormattNumberDecimalWithNumberHalfUp() {
        let result = dataHelper.formattNumberDecimal(number: 12.7675, point: 0)
        XCTAssertEqual("13", result)
    }
    
    func testFormattNumberDecimalWithNumberHalfDown() {
        let result = dataHelper.formattNumberDecimal(number: 12.4675, point: 0)
        XCTAssertEqual("12", result)
    }
    
    func testFormattNumberDecimalWithAddedComma() {
        let result = dataHelper.formattNumberDecimal(number: 2143.344321, point: 4)
        XCTAssertEqual("2,143.3443", result)
    }
    
    func testFormattNumberDecimalWithAddedCommaAndHalfUp() {
        let result = dataHelper.formattNumberDecimal(number: 2143.3821, point: 1)
        XCTAssertEqual("2,143.4", result)
    }
    
    func testFormattNumberDecimalWithNullNumber() {
        let result = dataHelper.formattNumberDecimal(number: nil, point: 1)
        XCTAssertEqual("", result)
    }
}
