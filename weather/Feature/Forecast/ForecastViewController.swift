//
//  WeatherViewController.swift
//  weather
//
//  Created by Supanat on 2/11/2563 BE.
//

import Foundation
import UIKit

protocol ForecastDisplayLogic {
    func getForecast5DaysOnComplete(viewModel: ForecastViewModel.Forecast5Days)
    func getForecast5DaysOnError(errorMessage: String)
}

class ForecastViewController: BaseViewController, ForecastDisplayLogic {

    var interactor: ForecastInteractor?
    var router: ForecastRouter?
    
    // MARK: UI
    @IBOutlet var tableView: UITableView!
    
    // MARK: Data
    var cityName: String?
    var weatherUnit: WeatherUnit?
    var forecastByDates = [ForecastViewModel.Forecast5Days.Forecast]()
    
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
        
        registerTableViewCell()
        setupView()
        setupData()
    }
    
    func setupData() {
        if let cityName = cityName {
            interactor?.getForecast5Days(cityName: cityName, weatherUnit: weatherUnit ?? .celsius)
        }
    }
    
    func setupView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 50
    }

    func getForecast5DaysOnComplete(viewModel: ForecastViewModel.Forecast5Days) {
        forecastByDates = viewModel.forecastByDates ?? []
        tableView.reloadData()
    }
    
    func getForecast5DaysOnError(errorMessage: String) {
        alertError(code: nil, message: errorMessage)
    }
}

extension ForecastViewController {
    func setup() {
        let viewController = self
        let interactor = ForecastInteractor()
        let presenter = ForecastPresenter()
        let router = ForecastRouter()
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
