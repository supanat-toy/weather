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
            var unit: String
        }
        
        struct Response: Decodable {
            var timezone: Int?
            var name: String?
            var weather: [Weather]?
            var main: Main?
            var wind: Wind?
            var clouds: Cloud?
            var sys: Sys?
            
            struct Weather: Decodable {
                var main: String? // Group of weather parameters (Rain, Snow, Extreme etc.)
                var description: String?
                var icon: String? // Weather icon id
            }
            
            struct Main: Decodable {
                var temp: Double?
                var feels_like: Double?
                var temp_min: Double?
                var temp_max: Double?
                var pressure: Double? // Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
                var humidity: Double? // Humidity, %
            }
            
            struct Wind: Decodable {
                var speed: Double? // Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
                var deg: Double? // Wind direction, degrees (meteorological)
            }
            
            struct Cloud: Decodable {
                var all: Double? // Cloudiness, %
            }
            
            struct Sys: Decodable {
                var country: String? // Country code (GB, JP etc.)
                var sunrise: Int64? // Sunrise time, unix, UTC
                var sunset: Int64? // Sunset time, unix, UTC
            }
        }
    }
    
    struct GetForecast5Days {
        struct Request: Encodable {
            var cityName: String
            var unit: String
        }
        
        struct Response: Decodable {
            var list: [Forecast]?
            
            struct Forecast: Decodable {
                var dt: Int64?
                var main: Main?
                var weather: [Weather]?
                var wind: Wind?
                var clouds: Cloud?
                
                struct Main: Decodable {
                    var temp: Double?
                    var temp_min: Double?
                    var temp_max: Double?
                    var pressure: Double? // Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
                    var humidity: Double? // Humidity, %
                    var sea_level: Double? // Atmospheric pressure on the sea level, hPa
                    var grnd_level: Double? // Atmospheric pressure on the ground level, hPa
                    var temp_kf: Double?
                }
                
                struct Weather: Decodable {
                    var main: String?
                    var description: String?
                    var icon: String?
                }
                
                struct Wind: Decodable {
                    var speed: Double? // Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
                    var deg: Double? // Wind direction, degrees (meteorological)
                }
                
                struct Cloud: Decodable {
                    var all: Double? // Cloudiness, %
                }
            }
        }
    }
}
