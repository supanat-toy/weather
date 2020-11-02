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
    
    func navigateToOrderStatusFundDetail() {
        self.viewController?.performSegue(withIdentifier: "gotoOrderStatusFundDetailSegue", sender: self.viewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoOrderStatusFundDetailSegue" {
            if let  destinationVC = segue.destination as? WeatherViewController {
                
            }
        }
    }
}
