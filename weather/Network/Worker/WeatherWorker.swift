//
//  WeatherWorker.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Moya
import RxSwift

protocol WeatherWorkerProtocol {
    func GetWeather(request: WeatherModel.GetWeather.Request) -> Observable<WeatherModel.GetWeather.Response>
    func GetForecast5Days(request: WeatherModel.GetForecast5Days.Request) -> Observable<WeatherModel.GetForecast5Days.Response>
}

public class WeatherWorker: WeatherWorkerProtocol {

    let provider: MoyaProvider<WeatherService>
    
    init(provider: MoyaProvider<WeatherService> = MoyaProvider<WeatherService>()) {
        self.provider = provider
    }
    
    func GetWeather(request: WeatherModel.GetWeather.Request) -> Observable<WeatherModel.GetWeather.Response> {
        
        return self.provider.rx.request(.getWeather(request: request))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(WeatherModel.GetWeather.Response.self)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
    
    func GetForecast5Days(request: WeatherModel.GetForecast5Days.Request) -> Observable<WeatherModel.GetForecast5Days.Response> {
        
        return self.provider.rx.request(.getForecast5Days(request: request))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(WeatherModel.GetForecast5Days.Response.self)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
}
