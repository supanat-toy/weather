//
//  WeatherInteractor.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import UIKit
import RxSwift

protocol ForecastBusinessLogic {
    func getForecast5Days(cityName: String, weatherUnit: WeatherUnit)
}

class ForecastInteractor: ForecastBusinessLogic {
    
    var presenter: ForecastPresentationLogic?
    var worker: WeatherWorkerProtocol?
    var disposeBag: DisposeBag = DisposeBag()
    
    init(presenter: ForecastPresentationLogic? = nil,
         weatherWorker: WeatherWorkerProtocol? = WeatherWorker()) {
        self.presenter = presenter
        self.worker = weatherWorker
    }
    
    func getForecast5Days(cityName: String, weatherUnit: WeatherUnit) {
        let request = WeatherModel.GetForecast5Days.Request(cityName: cityName, unit: weatherUnit.rawValue)
        let dispose = worker?.GetForecast5Days(request: request).subscribe(onNext: { (response) in
            self.presenter?.getForecast5DaysOnComplete(response: response, weatherUnit: weatherUnit)
        }, onError: { (error) in
            self.presenter?.getForecast5DaysOnError(error: error)
        })
        dispose?.disposed(by: disposeBag)
    }
}
