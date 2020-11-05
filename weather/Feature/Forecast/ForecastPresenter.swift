//
//  WeatherPresenter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation

protocol ForecastPresentationLogic {
    func getForecast5DaysOnComplete(response: WeatherModel.GetForecast5Days.Response, weatherUnit: WeatherUnit)
    func getForecast5DaysOnError(error: Error)
}

class ForecastPresenter: ForecastPresentationLogic {
    
    var viewController: ForecastDisplayLogic?
    
    func getForecast5DaysOnComplete(response: WeatherModel.GetForecast5Days.Response, weatherUnit: WeatherUnit) {
        let unit = weatherUnit == .celsius ? "C" : "F"
        var forecastByDates = [ForecastViewModel.Forecast5Days.Forecast]()
        
        response.list?.forEach({ (forecast) in
            var date = ""
            var time = ""
            if let milliseconds = forecast.dt {
                let dt = Date(milliseconds: milliseconds)
                date = dt.formattedString(format: "EEEE, MMMM d")
                time = dt.formattedString(format: "HH:mm")
            }
            
            let value = ForecastViewModel.Forecast5Days.Forecast.Value(
                time: time,
                tempMaxMin: "\(DataHelper.shared.formattNumberDecimal(number: forecast.main?.temp_max, point: 0))/\(DataHelper.shared.formattNumberDecimal(number: forecast.main?.temp_min, point: 0))°\(unit)",
                weathericonURL: "http://openweathermap.org/img/wn/\(forecast.weather?.first?.icon ?? "")@2x.png",
                weatherDescription: forecast.weather?.first?.description ?? ""
            )
            
            if let index = forecastByDates.firstIndex(where: { (va) -> Bool in
                return va.date == date
            }), index != -1 {
                forecastByDates[index].values.append(value)
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

