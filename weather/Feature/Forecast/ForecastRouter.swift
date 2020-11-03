//
//  WeatherRouter.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import UIKit

protocol ForecastRoutingLogic {
    func navigateToOrderStatusFundDetail()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class ForecastRouter {
    var viewController: ForecastViewController?
    
    func navigateToOrderStatusFundDetail() {
        self.viewController?.performSegue(withIdentifier: "gotoOrderStatusFundDetailSegue", sender: self.viewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoOrderStatusFundDetailSegue" {
            if let  destinationVC = segue.destination as? ForecastViewController {
                
            }
        }
    }
}
