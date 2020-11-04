//
//  WeatherViewController.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation
import UIKit

protocol WeatherDisplayLogic {
    func getCurrentWeatherOnComplete(viewModel: WeatherViewModel.Weather)
    func getCurrentWeatherOnError(errorMessage: String)
}

class WeatherViewController: BaseViewController, WeatherDisplayLogic {

    var interactor: WeatherInteractor?
    var router: WeatherRouter?
    
    // MARK: UI
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var weatherImageView: UIImageView!
    
    // MARK: Data
    var cityName: String?
    
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
        
        cityTextField.text = "Sukhumvit, TH"
        getCurrentWeather()
    }
    
    @IBAction func searchOnClick(_ sender: UIButton) {
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        if let cityName = cityTextField.text {
            self.cityName = cityName
            interactor?.getCurrentWeather(cityName: cityName)
        }
    }
    
    @IBAction func forecastOnClick(_ sender: UIBarButtonItem) {
        router?.navigateToForecastSegue()
    }
    
    func getCurrentWeatherOnComplete(viewModel: WeatherViewModel.Weather) {
        temperatureLabel.text = "\(viewModel.temp ?? 0.0)"
        humidityLabel.text = "\(viewModel.humidity ?? 0.0)"
    }
    
    func getCurrentWeatherOnError(errorMessage: String) {
        alertError(code: nil, message: errorMessage)
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
