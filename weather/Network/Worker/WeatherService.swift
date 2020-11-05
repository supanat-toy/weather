//
//  WeatherService.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Moya
import Alamofire

enum WeatherService {
    case getWeather(request: WeatherModel.GetWeather.Request)
    case getForecast5Days(request: WeatherModel.GetForecast5Days.Request)
}


extension WeatherService: TargetType {

    public var baseURL: URL {
        return URL(string: "http://api.openweathermap.org/data/2.5")!
    }
    
    public var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        case .getForecast5Days:
            return "/forecast"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getWeather,
             .getForecast5Days:
            return Method.get
        }
    }

    public var parameters: [String: Any] {
        switch self {
        case .getWeather(let request):
            return ["q": request.cityName,
                    "units": request.unit,
                    "appid": "2b0f295dfc1c56bf9d42c2b0853d5167"]
        case .getForecast5Days(let request):
            return ["q": request.cityName,
                    "units": request.unit,
                    "appid": "2b0f295dfc1c56bf9d42c2b0853d5167"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
        
    public var task: Task {
        return Task.requestParameters(parameters: parameters, encoding: Alamofire.URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return [:]
    }
}
