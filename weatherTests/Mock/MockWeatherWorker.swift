//
//  MockWeatherWorker.swift
//  weatherTests
//
//  Created by Supanat on 6/11/2563 BE.
//

import RxSwift
import Moya
@testable import weather

class MockWeatherWorkerSuccess: WeatherWorkerProtocol {
    func GetWeather(request: WeatherModel.GetWeather.Request) -> Observable<WeatherModel.GetWeather.Response> {
        return Observable.create { (observable) -> Disposable in
            observable.onNext(
                WeatherModel.GetWeather.Response(
                    timezone: 10324453,
                    name: "Bangkok",
                    weather: [WeatherModel.GetWeather.Response.Weather(
                                main: "cloud",
                                description: "clear cloud",
                                icon: "10d")
                    ],
                    main: WeatherModel.GetWeather.Response.Main(
                        temp: 38.21,
                        feels_like: 38.43,
                        temp_min: 38.18,
                        temp_max: 40.45,
                        pressure: 12.4,
                        humidity: 40
                    ),
                    wind: WeatherModel.GetWeather.Response.Wind(
                        speed: 24,
                        deg: 140
                    ),
                    clouds: WeatherModel.GetWeather.Response.Cloud(all: 70),
                    sys: WeatherModel.GetWeather.Response.Sys(
                        country: "TH",
                        sunrise: 10324233,
                        sunset: 10231232
                    )
                )
            )
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    func GetForecast5Days(request: WeatherModel.GetForecast5Days.Request) -> Observable<WeatherModel.GetForecast5Days.Response> {
        return Observable.create { (observable) -> Disposable in
            observable.onNext(WeatherModel.GetForecast5Days.Response(
                                list: [
                                    WeatherModel.GetForecast5Days.Response.Forecast(
                                        dt: 104323312,
                                        main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                                            temp: 37.23,
                                            temp_min: 37.02,
                                            temp_max: 39.43,
                                            pressure: 124,
                                            humidity: 300,
                                            sea_level: 2.4,
                                            grnd_level: 12.34,
                                            temp_kf: 38.33
                                        ),
                                        weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                                    main: "Rain",
                                                    description: "heavy rain",
                                                    icon: "11d")
                                        ],
                                        wind: WeatherModel.GetForecast5Days.Response.Forecast.Wind(
                                            speed: 214,
                                            deg: 104
                                        ),
                                        clouds: WeatherModel.GetForecast5Days.Response.Forecast.Cloud(all: 80)
                                    ),
                                    WeatherModel.GetForecast5Days.Response.Forecast(
                                        dt: 104324342,
                                        main: WeatherModel.GetForecast5Days.Response.Forecast.Main(
                                            temp: 37.23,
                                            temp_min: 37.19,
                                            temp_max: 38.54,
                                            pressure: 230,
                                            humidity: 350,
                                            sea_level: 120,
                                            grnd_level: 214,
                                            temp_kf: 38.23
                                        ),
                                        weather: [WeatherModel.GetForecast5Days.Response.Forecast.Weather(
                                                    main: "Cloud",
                                                    description: "Clear cloud",
                                                    icon: "02n")
                                        ],
                                        wind: WeatherModel.GetForecast5Days.Response.Forecast.Wind(
                                            speed: 1234,
                                            deg: 21
                                        ),
                                        clouds: WeatherModel.GetForecast5Days.Response.Forecast.Cloud(all: 55)
                                    )
                                ])
            )
            observable.onCompleted()
            return Disposables.create()
        }
    }
}

class MockWeatherWorkerError: WeatherWorkerProtocol {
    
    let error = """
                {
                "cod": "Error-500",
                "message": "Something is wrong!"
                }
        """
    
    func GetWeather(request: WeatherModel.GetWeather.Request) -> Observable<WeatherModel.GetWeather.Response> {
        return Observable.create { (observable) -> Disposable in
            observable.onError(MoyaError.statusCode(Response(statusCode: 500, data: self.error.data(using: .utf8)!)))
            return Disposables.create()
        }
    }
    
    func GetForecast5Days(request: WeatherModel.GetForecast5Days.Request) -> Observable<WeatherModel.GetForecast5Days.Response> {
        return Observable.create { (observable) -> Disposable in
            observable.onError(MoyaError.statusCode(Response(statusCode: 500, data: self.error.data(using: .utf8)!)))
            return Disposables.create()
        }
    }
    
    
}
