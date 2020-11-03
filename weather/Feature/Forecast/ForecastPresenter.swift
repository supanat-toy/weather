//
//  WeatherPresenter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

protocol ForecastPresentationLogic {
    func getForecast5DaysOnComplete(response: WeatherModel.GetForecast5Days.Response)
    func getForecast5DaysOnError(error: Error)
}

class ForecastPresenter: ForecastPresentationLogic {
    
    var viewController: ForecastDisplayLogic?
    
    func getForecast5DaysOnComplete(response: WeatherModel.GetForecast5Days.Response) {
        
        let forecastList = response.list?.compactMap({ (forecast) -> ForecastViewModel.Forecast5Days.Forecast? in
            
            var dateString: String?
            if let milliseconds = forecast.dt {
                let date = Date(milliseconds: milliseconds)
                dateString = date.formattedString(format: "dd/MM/yyyy HH:mm:ss")
            }
            
            return ForecastViewModel.Forecast5Days.Forecast(
                date: dateString,
                humidity: forecast.main?.humidity,
                temp: forecast.main?.temp
            )
        })
        
        let weatherViewModel = ForecastViewModel.Forecast5Days(
            forecastList: forecastList
        )
        viewController?.getForecast5DaysOnComplete(viewModel: weatherViewModel)
    }
    
    func getForecast5DaysOnError(error: Error) {
        viewController?.getForecast5DaysOnError(errorMessage: error.localizedDescription)
    }
}
