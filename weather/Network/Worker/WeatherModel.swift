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
            var timezone: Int?
            var name: String?
            var cod: Int?
            var weather: [Weather]?
            var main: Main?
            
            struct Weather: Decodable {
                var icon: String?
                var description: String?
            }
            
            struct Main: Decodable {
                var temp: Double?
                var temp_min: Double?
                var temp_max: Double?
                var pressure: Double?
                var humidity: Double?
            }
        }
    }
    
    struct GetForecast5Days {
        struct Request: Encodable {
            var cityName: String
        }
        
        struct Response: Decodable {
            var list: [Forecast]?
            
            struct Forecast: Decodable {
                var dt: Int64?
                var main: Main?
                
                struct Main: Decodable {
                    var temp: Double?
                    var temp_min: Double?
                    var temp_max: Double?
                    var pressure: Double?
                    var humidity: Double?
                }
            }
        }
    }
}
