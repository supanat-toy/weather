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

enum WeatherUnit: String {
    case celsius = "metric"
    case fahrenheit = "imperial"
    
    var title: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }
}

class WeatherViewController: BaseViewController, WeatherDisplayLogic {

    var interactor: WeatherInteractor?
    var router: WeatherRouter?
    
    // MARK: UI
    @IBOutlet var containerTopView: UIView!
    @IBOutlet var containerBelowView: UIView!
    
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var cloudLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var weatherUnitButton: UIButton!
    
    // MARK: Data
    var cityName: String?
    var weatherUnit: WeatherUnit = .celsius
    
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
    
    func setupView() {
        containerTopView.layer.masksToBounds = false
        containerTopView.layer.shadowColor = UIColor.white.cgColor
        containerTopView.layer.shadowOpacity = 0.5
        containerTopView.layer.shadowOffset = .zero
        containerTopView.layer.shadowRadius = 5
        containerTopView.layer.cornerRadius = 5
        
        containerBelowView.layer.masksToBounds = false
        containerBelowView.layer.shadowColor = UIColor.darkGray.cgColor
        containerBelowView.layer.shadowOpacity = 0.5
        containerBelowView.layer.shadowOffset = .zero
        containerBelowView.layer.shadowRadius = 5
        containerBelowView.layer.cornerRadius = 5
    }
    
    @IBAction func searchOnClick(_ sender: UIButton) {
        getCurrentWeather()
    }
    
    @IBAction func changeWeatherUnit(_ sender: UIButton) {
        weatherUnit = weatherUnit == .celsius ? .fahrenheit : .celsius
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        weatherUnitButton.setTitle(weatherUnit.title, for: .normal)
        if let cityName = cityTextField.text {
            self.cityName = cityName
            let unit = weatherUnit
            
            self.showLoadingView()
            interactor?.getCurrentWeather(cityName: cityName, weatherUnit: unit)
        }
    }
    
    @IBAction func forecastOnClick(_ sender: UIBarButtonItem) {
        router?.navigateToForecastSegue()
    }
    
    func getCurrentWeatherOnComplete(viewModel: WeatherViewModel.Weather) {
        dismissLoadingView {
            self.temperatureLabel.text = viewModel.temp
            self.humidityLabel.text = viewModel.humidity
            self.pressureLabel.text = viewModel.pressure
            self.cloudLabel.text = viewModel.cloud
            self.windSpeedLabel.text = viewModel.windSpeed
            self.weatherDescriptionLabel.text = viewModel.weatherDescriotion
            self.weatherImageView.downloaded(from: viewModel.weathericonURL)
        }
    }
    
    func getCurrentWeatherOnError(errorMessage: String) {
        dismissLoadingView {
            self.alertError(code: nil, message: errorMessage)
        }
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
