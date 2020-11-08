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

    var interactor: WeatherBusinessLogic?
    var router: WeatherRoutingLogic?
    
    // MARK: UI
    @IBOutlet var containerTopView: UIView!
    
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var timezoneLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var cloudLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var weatherUnitButton: UIButton!
    
    // MARK: Data
    var weatherDataStore: WeatherDataStore?
    
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
        
        setupView()
        setupData()
        getCurrentWeather()
    }
    
    func setupData() {
        weatherDataStore = WeatherDataStore(weatherUnit: .celsius)
    }
    
    func setupView() {
        setTapGestureKeyboard(tapView: self.view)
        cityTextField.text = "Sukhumvit, TH"
    }
    
    @IBAction func searchOnClick(_ sender: UIButton) {
        hideKeyboard()
        getCurrentWeather()
    }
    
    @IBAction func changeWeatherUnitOnClick(_ sender: UIButton) {
        hideKeyboard()
        var weatherUnit = weatherDataStore?.weatherUnit ?? .celsius
        weatherUnit = weatherUnit == .celsius ? .fahrenheit : .celsius
        weatherDataStore?.weatherUnit = weatherUnit
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        weatherUnitButton.setTitle(weatherDataStore?.weatherUnit.title, for: .normal)
        if let cityName = cityTextField.text {
            if cityName.isEmpty {
                self.alertError(message: "City name is empty")
            } else {
                self.showLoadingView()
                interactor?.getCurrentWeather(cityName: cityName, weatherUnit: weatherDataStore?.weatherUnit ?? .celsius)
            }
        }
    }
    
    @IBAction func forecastOnClick(_ sender: UIBarButtonItem) {
        hideKeyboard()
        if let _ = weatherDataStore?.cityName {
            router?.navigateToForecastSegue()
        } else {
            alertError(message: "Invalid city name")
        }
        
    }
    
    func getCurrentWeatherOnComplete(viewModel: WeatherViewModel.Weather) {
        dismissLoadingView {
            self.setDataValue(viewModel: viewModel)
        }
    }
    
    func setDataValue(viewModel: WeatherViewModel.Weather?) {
        self.temperatureLabel.text = viewModel?.temp ?? "N/A"
        self.timezoneLabel.text = viewModel?.time ?? "N/A"
        self.humidityLabel.text = viewModel?.humidity ?? "N/A"
        self.pressureLabel.text = viewModel?.pressure ?? "N/A"
        self.cloudLabel.text = viewModel?.cloud ?? "N/A"
        self.windSpeedLabel.text = viewModel?.windSpeed ?? "N/A"
        self.weatherDescriptionLabel.text = viewModel?.weatherDescriotion ?? "N/A"
        
        if let weathericonURL = viewModel?.weathericonURL {
            self.weatherImageView.downloaded(from: weathericonURL)
        } else {
            self.weatherImageView.image = UIImage()
        }
        
        self.weatherDataStore?.cityName = viewModel?.cityName
        self.weatherDataStore?.temperature = viewModel?.temp
        self.weatherDataStore?.weatherImageURL = viewModel?.weathericonURL
        self.weatherDataStore?.weatherDescription = viewModel?.weatherDescriotion
    }
    
    func getCurrentWeatherOnError(errorMessage: String) {
        dismissLoadingView {
            self.setDataValue(viewModel: nil)
            self.alertError(message: errorMessage)
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
