//
//  WeatherRouter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import UIKit

protocol ForecastRoutingLogic {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class ForecastRouter {
    var viewController: ForecastViewController?
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
