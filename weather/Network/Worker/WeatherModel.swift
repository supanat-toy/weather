//
//  WeatherModel.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

enum WeatherModel {
    struct GetWeather {
        struct Request: Encodable {
            var cityName: String
        }
        
        struct Response: Decodable {
            var fundFactSheetUrl: String?
        }
    }
    
    struct GetForecast5Days {
        struct Request: Encodable {
            var cityName: String
        }
        
        struct Response: Decodable {
            var fundFactSheetUrl: String?
        }
    }
}
