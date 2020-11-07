//
//  ForecastTableViewCellTest.swift
//  weatherTests
//
//  Created by Supanat on 7/11/2563 BE.
//

import Foundation
import UIKit
import XCTest
@testable import weather

class ForecastTableViewCellTest: XCTestCase {
    var forecastTableViewCell: ForecastTableViewCell!
    
    let timeLabel = UILabel(frame: .zero)
    let tempLabel = UILabel(frame: .zero)
    let weatherImageView = UIImageView(frame: .zero)
    let descriptionLabel = UILabel(frame: .zero)
    
    override func setUp() {
        super.setUp()
        
        forecastTableViewCell = ForecastTableViewCell(frame: .zero)
     
        forecastTableViewCell.timeLabel = timeLabel
        forecastTableViewCell.tempLabel = tempLabel
        forecastTableViewCell.weatherImageView = weatherImageView
        forecastTableViewCell.descriptionLabel = descriptionLabel
    }
    
    func testForecastTableViewSetCell() {
        let mockViewModel = ForecastViewModel.Forecast5Days.Forecast.Value(
            time: "22:00",
            tempMaxMin: "28/26°C",
            weathericonURL: "http://openweathermap.org/img/wn/10d@4x.png",
            weatherDescription: "light rain"
        )
        
        forecastTableViewCell.setCell(viewModel: mockViewModel)
        
        XCTAssertEqual("22:00", forecastTableViewCell.timeLabel.text)
        XCTAssertEqual("28/26°C", forecastTableViewCell.tempLabel.text)
        XCTAssertEqual(.scaleAspectFit, forecastTableViewCell.weatherImageView.contentMode)
        XCTAssertEqual("light rain", forecastTableViewCell.descriptionLabel.text)
    }
    
    func testForecastTableViewCellPrepareForReuse() {
        forecastTableViewCell.prepareForReuse()
        
        XCTAssertEqual("", forecastTableViewCell.timeLabel.text)
        XCTAssertEqual("", forecastTableViewCell.tempLabel.text)
        XCTAssertEqual(UIImage(), forecastTableViewCell.weatherImageView.image)
        XCTAssertEqual("", forecastTableViewCell.descriptionLabel.text)
    }
    
    func testForecastTableViewCellAwakeFromNib() {
        forecastTableViewCell.awakeFromNib()
        
        XCTAssertEqual(.none, forecastTableViewCell.selectionStyle)
        XCTAssertEqual(.white, forecastTableViewCell.backgroundColor)
    }
}
