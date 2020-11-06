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

class ForecastRouter: ForecastRoutingLogic {
    var viewController: ForecastViewController?
    
    init(viewController: ForecastViewController? = nil) {
        self.viewController = viewController
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
