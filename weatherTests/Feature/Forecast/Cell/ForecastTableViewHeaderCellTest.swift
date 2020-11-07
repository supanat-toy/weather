//
//  ForecastTableViewHeaderCellTest.swift
//  weatherTests
//
//  Created by Supanat on 7/11/2563 BE.
//

import Foundation
import UIKit
import XCTest
@testable import weather

class ForecastTableViewHeaderCellTest: XCTestCase {
    var forecastTableViewHeaderCell: ForecastTableViewHeaderCell!
    
    let titleLabel = UILabel(frame: .zero)
    
    override func setUp() {
        super.setUp()
        
        forecastTableViewHeaderCell = ForecastTableViewHeaderCell(frame: .zero)
        forecastTableViewHeaderCell.titleLabel = titleLabel
    }
    
    func testForecastTableViewHeaderCellSetCell() {
        forecastTableViewHeaderCell.setCell(title: "Monday, November 2")
        
        XCTAssertEqual("Monday, November 2", forecastTableViewHeaderCell.titleLabel.text)
    }
    
    func testForecastTableViewHeaderCellPrepareForReuse() {
        forecastTableViewHeaderCell.prepareForReuse()
        
        XCTAssertEqual("", forecastTableViewHeaderCell.titleLabel.text)
    }
    
    func testForecastTableViewHeaderCellAwakeFromNib() {
        forecastTableViewHeaderCell.awakeFromNib()
        
        XCTAssertEqual(nil, forecastTableViewHeaderCell.backgroundColor)
    }
}
