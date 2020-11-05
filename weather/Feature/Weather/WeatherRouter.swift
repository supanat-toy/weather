//
//  WeatherRouter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import UIKit

protocol WeatherRoutingLogic {
    func navigateToOrderStatusFundDetail()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class WeatherRouter {
    var viewController: WeatherViewController?
    
    func navigateToForecastSegue() {
        self.viewController?.performSegue(withIdentifier: "gotoForecastSegue", sender: self.viewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoForecastSegue" {
            if let destinationVC = segue.destination as? ForecastViewController {
                destinationVC.cityName = viewController?.cityName
                destinationVC.weatherUnit = viewController?.weatherUnit
            }
        }
    }
}
