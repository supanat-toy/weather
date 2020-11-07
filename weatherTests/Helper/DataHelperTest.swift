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
    
    func testFormattNumberDecimalWithNilNumberIsZero() {
        let result = dataHelper.formattNumberDecimal(number: nil, point: 4)
        XCTAssertEqual("0.0000", result)
    }
}
