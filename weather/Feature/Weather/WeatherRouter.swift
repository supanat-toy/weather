//
//  WeatherRouter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import UIKit

protocol WeatherRoutingLogic {
    func navigateToForecastSegue()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class WeatherRouter: WeatherRoutingLogic {
    var viewController: WeatherViewController?
    
    init(viewController: WeatherViewController? = nil) {
        self.viewController = viewController
    }
    
    func navigateToForecastSegue() {
        self.viewController?.performSegue(withIdentifier: "gotoForecastSegue", sender: self.viewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoForecastSegue" {
            if let destinationVC = segue.destination as? ForecastViewController {
                destinationVC.weatherDataStore = viewController?.weatherDataStore
            }
        }
    }
}
