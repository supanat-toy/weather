//
//  WeatherPresenter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

protocol WeatherPresentationLogic {
    func getWeatherOnComplete(response: WeatherModel.GetWeather.Response)
    func getWeatherOnError(error: Error)
}

class WeatherPresenter: WeatherPresentationLogic {
    
    var viewController: WeatherDisplayLogic?
    
    func getWeatherOnComplete(response: WeatherModel.GetWeather.Response) {
        
        let weatherViewModel = WeatherViewModel.Weather(
            timezone: response.timezone,
            name: response.name,
            cod: response.cod,
            humidity: response.main?.humidity,
            temp: response.main?.temp
        )
        viewController?.getCurrentWeatherOnComplete(viewModel: weatherViewModel)
    }
    
    func getWeatherOnError(error: Error) {
        viewController?.getCurrentWeatherOnError(errorMessage: error.localizedDescription)
    }
}
