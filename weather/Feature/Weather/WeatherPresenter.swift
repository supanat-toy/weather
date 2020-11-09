//
//  WeatherPresenter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

protocol WeatherPresentationLogic {
    func getWeatherOnComplete(response: WeatherModel.GetWeather.Response, cityName: String, weatherUnit: WeatherUnit)
    func getWeatherOnError(error: NetworkError)
}

class WeatherPresenter: WeatherPresentationLogic {
    
    var viewController: WeatherDisplayLogic?
    
    init(viewController: WeatherDisplayLogic? = nil) {
        self.viewController = viewController
    }
    
    func getWeatherOnComplete(response: WeatherModel.GetWeather.Response, cityName: String, weatherUnit: WeatherUnit) {
        let tempUnit = weatherUnit == .celsius ? "C" : "F"
        let windSpeed = weatherUnit == .celsius ? "meter/sec" : "miles/hour"
        
        var time: String?
        if let timezone = response.dt {
            let dt = Date(milliseconds: timezone)
            time = dt.formattedString(format: "HH:mm")
        }
        
        let weatherViewModel = WeatherViewModel.Weather(
            cityName: cityName,
            time: time ?? "N/A",
            pressure: DataHelper.shared.formattNumberDecimal(number: response.main?.pressure, point: 0) + " hPa",
            weatherDescriotion: response.weather?.first?.description?.capitalized ?? "",
            windSpeed: DataHelper.shared.formattNumberDecimal(number: response.wind?.speed, point: 2) + " " + windSpeed,
            humidity: DataHelper.shared.formattNumberDecimal(number: response.main?.humidity, point: 0) + "%",
            temp: (DataHelper.shared.formattNumberDecimal(number: response.main?.temp, point: 0)) + "°" + tempUnit ,
            cloud: DataHelper.shared.formattNumberDecimal(number: response.clouds?.all, point: 0) + "%",
            weathericonURL: "http://openweathermap.org/img/wn/\(response.weather?.first?.icon ?? "")@4x.png"
        )
        viewController?.getCurrentWeatherOnComplete(viewModel: weatherViewModel)
    }
    
    func getWeatherOnError(error: NetworkError) {
        let errorMessage = "Error code: \(error.code ?? "")\nMessage: \(error.message ?? "")"
        
        let weatherViewModel = WeatherViewModel.Weather(
            cityName: "N/A",
            time: "N/A",
            pressure: "N/A",
            weatherDescriotion: "N/A",
            windSpeed: "N/A",
            humidity: "N/A",
            temp: "N/A",
            cloud: "N/A",
            weathericonURL: ""
        )
        viewController?.getCurrentWeatherOnError(errorMessage: errorMessage, viewModel: weatherViewModel)
    }
}
