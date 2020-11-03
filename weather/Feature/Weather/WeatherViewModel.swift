//
//  WeatherViewModel.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

enum WeatherViewModel {
    
    struct Weather {
        var timezone: Int?
        var name: String?
        var cod: Int?
        var humidity: Double?
        var temp: Double?
    }
}
