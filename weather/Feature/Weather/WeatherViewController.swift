//
//  WeatherViewController.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation
import UIKit

protocol WeatherDisplayLogic {
    
}

class WeatherViewController: ViewController, WeatherDisplayLogic {
    // MARK: Data Store
    var interactor: WeatherInteractor?
    var router: WeatherRouter?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.getCurrentWeather()
    }
}

extension WeatherViewController {
    func setup() {
        let viewController = self
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let router = WeatherRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.router?.prepare(for: segue, sender: sender)
    }
}
