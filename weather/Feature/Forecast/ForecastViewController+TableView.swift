//
//  HomeViewController+TableView.swift
//  aomwise
//
//  Created by Supanat Toy on 5/9/2562 BE.
//  Copyright © 2562 settrade. All rights reserved.
//

import UIKit

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewCell() {
        tableView.register(
            UINib(nibName: ForecastTableViewCell.identifier, bundle: Bundle.main),
            forCellReuseIdentifier: ForecastTableViewCell.identifier
        )
        
        tableView.register(UINib(
        nibName: ForecastTableViewHeaderCell.identifier, bundle: Bundle.main),
                           forHeaderFooterViewReuseIdentifier: ForecastTableViewHeaderCell.identifier
        )
        
        tableView.backgroundView = self.tableErrorView
    }
    
    func setupTableView() {
        if forecastByDates == nil {
            tableErrorView?.setView(title: "Error",
                                    subTitle: "City name not found.",
                                    image: UIImage(named: "icon-error-box"))
             
        } else if forecastByDates?.isEmpty ?? false {
            tableErrorView?.setView(title: "Data not found",
                                    subTitle: "Forecast weather is empty",
                                    image: UIImage(named: "icon-empty-box"))
        }
        
        let showMessage = forecastByDates?.count ?? 0 == 0
        
        tableErrorView?.isHidden = !showMessage
        tableView.separatorStyle = showMessage ? .none : .singleLine
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastByDates?[section].values.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastByDates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < forecastByDates?.count ?? 0 {
            return UITableView.automaticDimension
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section < forecastByDates?.count ?? 0,
           let forecastByDate = forecastByDates?[section].date {
            guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ForecastTableViewHeaderCell.identifier)
                as? ForecastTableViewHeaderCell else {
                return UITableViewHeaderFooterView()
            }
            
            cell.setCell(title: forecastByDate)
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ForecastTableViewCell.identifier,
            for: indexPath
        ) as? ForecastTableViewCell else {
            return UITableViewCell()
        }
        
        let forecastTime = forecastByDates?[indexPath.section].values[indexPath.row]
        cell.setCell(viewModel: forecastTime)
        
        return cell
        
    }
}
