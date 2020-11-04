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
        
        var forecastByDates = [ForecastViewModel.Forecast5Days.Forecast]()
        
        response.list?.forEach({ (forecast) in
            var date: String?
            var time: String?
            if let milliseconds = forecast.dt {
                let dt = Date(milliseconds: milliseconds)
                date = dt.formattedString(format: "dd/MM/yyyy")
                time = dt.formattedString(format: "HH:mm")
            }
            
            let value = ForecastViewModel.Forecast5Days.Forecast.Value(
                time: time,
                humidity: String(format: "%.2f", forecast.main?.humidity ?? 0.0),
                temp: String(format: "%.2f", forecast.main?.temp ?? 0.0)
            )
            
            if let index = forecastByDates.firstIndex(where: { (va) -> Bool in
                return va.date == date
            }), index != -1 {
                forecastByDates[index].values?.append(value)
            } else {
                let forecastDate = ForecastViewModel.Forecast5Days.Forecast(
                    date: date,
                    values: [value]
                )
                forecastByDates.append(forecastDate)
            }
        })
        
        let weatherViewModel = ForecastViewModel.Forecast5Days(
            forecastByDates: forecastByDates
        )
        viewController?.getForecast5DaysOnComplete(viewModel: weatherViewModel)
    }
    
    func getForecast5DaysOnError(error: Error) {
        viewController?.getForecast5DaysOnError(errorMessage: error.localizedDescription)
    }
}

