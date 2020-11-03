//
//  WeatherViewModel.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

enum ForecastViewModel {
    
    struct Forecast5Days {
        var forecastList: [Forecast]?
        
        struct Forecast {
            var date: String?
            var humidity: Double?
            var temp: Double?
        }
    }
}
