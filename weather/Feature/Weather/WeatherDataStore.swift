//
//  WeatherDataStore.swift
//  weather
//
//  Created by Supanat on 7/11/2563 BE.
//

import Foundation

struct WeatherDataStore {
    var cityName: String?
    var weatherUnit: WeatherUnit
    var temperature: String?
    var weatherDescription: String?
    var weatherImageURL: String?
    
    init(weatherUnit: WeatherUnit) {
        self.weatherUnit = weatherUnit
    }
    
    init(cityName: String?, weatherUnit: WeatherUnit, temperature: String?, weatherDescription: String?, weatherImageURL: String?) {
        self.cityName = cityName
        self.weatherUnit = weatherUnit
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.weatherImageURL = weatherImageURL
    }
}
