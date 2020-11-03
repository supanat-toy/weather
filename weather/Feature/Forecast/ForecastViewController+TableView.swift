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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastViewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let forecastViewModel = forecastViewModelList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ForecastTableViewCell.identifier,
            for: indexPath
        ) as? ForecastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCell()
        return cell
        
    }
}
