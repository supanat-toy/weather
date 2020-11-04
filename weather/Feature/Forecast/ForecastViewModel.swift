//
//  WeatherViewModel.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

enum ForecastViewModel {
    
    struct Forecast5Days {
        var forecastByDates: [Forecast]?
        
        struct Forecast {
            var date: String?
            var values: [Value]?
            
            struct Value {
                var time: String?
                var humidity: String?
                var temp: String?
            }
        }
    }
}
