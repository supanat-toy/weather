//
//  WeatherInteractor.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import UIKit
import RxSwift
import Moya

protocol WeatherBusinessLogic {
    func getCurrentWeather(cityName: String, weatherUnit: WeatherUnit)
}

class WeatherInteractor: WeatherBusinessLogic {
    
    var presenter: WeatherPresentationLogic?
    var worker: WeatherWorkerProtocol?
    var disposeBag: DisposeBag = DisposeBag()
    
    init(presenter: WeatherPresentationLogic? = nil,
         weatherWorker: WeatherWorkerProtocol? = WeatherWorker()) {
        self.presenter = presenter
        self.worker = weatherWorker
    }
    
    func getCurrentWeather(cityName: String, weatherUnit: WeatherUnit) {
        let request = WeatherModel.GetWeather.Request(cityName: cityName, unit: weatherUnit.rawValue)
        let dispose = worker?.GetWeather(request: request).subscribe(onNext: { (response) in
            self.presenter?.getWeatherOnComplete(response: response, weatherUnit: weatherUnit)
        }, onError: { (error) in
            self.presenter?.getWeatherOnError(error: NetworkError(error: error))
        })
        dispose?.disposed(by: disposeBag)
    }
}
