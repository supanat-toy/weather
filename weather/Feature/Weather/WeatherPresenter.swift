//
//  WeatherPresenter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

protocol WeatherPresentationLogic {
    func getWeatherOnComplete(response: WeatherModel.GetWeather.Response, weatherUnit: WeatherUnit)
    func getWeatherOnError(error: Error)
}

class WeatherPresenter: WeatherPresentationLogic {
    
    var viewController: WeatherDisplayLogic?
    
    func getWeatherOnComplete(response: WeatherModel.GetWeather.Response, weatherUnit: WeatherUnit) {
        let unit = weatherUnit == .celsius ? "C" : "F"
        
        let weatherViewModel = WeatherViewModel.Weather(
            pressure: DataHelper.shared.formattNumberDecimal(number: response.main?.pressure, point: 0) + " hPa",
            weatherDescriotion: response.weather?.first?.description ?? "",
            windSpeed: DataHelper.shared.formattNumberDecimal(number: response.wind?.speed, point: 2) + " m/s NE",
            humidity: DataHelper.shared.formattNumberDecimal(number: response.main?.humidity, point: 0) + "%",
            temp: (DataHelper.shared.formattNumberDecimal(number: response.main?.temp, point: 0)) + "°" + unit ,
            cloud: DataHelper.shared.formattNumberDecimal(number: response.clouds?.all, point: 0) + "%",
            weathericonURL: "http://openweathermap.org/img/wn/\(response.weather?.first?.icon ?? "")@2x.png"
        )
        viewController?.getCurrentWeatherOnComplete(viewModel: weatherViewModel)
    }
    
    func getWeatherOnError(error: Error) {
        viewController?.getCurrentWeatherOnError(errorMessage: error.localizedDescription)
    }
}
