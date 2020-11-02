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
        return URL(string: "")!
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
            return ["q": request.cityName]
        case .getForecast5Days(let request):
            return ["q": request.cityName]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
        
    public var task: Task {
        let encoding:ParameterEncoding =
            self.method == .post ? Alamofire.JSONEncoding.default : Alamofire.URLEncoding.default
        return Task.requestParameters(parameters: parameters, encoding: encoding)
    }
    
    public var headers: [String : String]? {
        return [:]
    }
}
