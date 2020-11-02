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
        
    }
    
    func getWeatherOnError(error: Error) {
        
    }
}
