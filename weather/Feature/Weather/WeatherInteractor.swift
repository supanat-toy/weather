//
//  WeatherInteractor.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import UIKit
import RxSwift

protocol WeatherBusinessLogic {
    func getCurrentWeather(cityName: String)
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
    
    func getCurrentWeather(cityName: String) {
        let request = WeatherModel.GetWeather.Request(cityName: cityName)
        let dispose = worker?.GetWeather(request: request).subscribe(onNext: { (response) in
            self.presenter?.getWeatherOnComplete(response: response)
        }, onError: { (error) in
            self.presenter?.getWeatherOnError(error: error)
        })
        dispose?.disposed(by: disposeBag)
    }
}
