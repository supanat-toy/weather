//
//  ForecastTableViewCell.swift
//  DealerDashboard
//
//  Created by Supanat on 3/11/2563 BE.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    // MARK: UI
//    @IBOutlet weak var shadowView: UIView!
//    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var badgeView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: Data
    static let identifier = "ForecastTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
//
//        shadowView.layer.masksToBounds = false
//        shadowView.layer.shadowColor = AppColor.boxShadow.cgColor
//        shadowView.layer.shadowOpacity = 0.5
//        shadowView.layer.shadowOffset = .zero
//        shadowView.layer.shadowRadius = 5
//        shadowView.layer.cornerRadius = 5
//
//        containerView.layer.cornerRadius = 5
//
//        accountWarningBadgeView.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        badgeView.backgroundColor = AppColor.grey
//        accountNumberLabel.text = ""
//        planNameLabel.text = ""
//        accountStateLabel.text = ""
    }
    
    func setCell(viewModel: ForecastViewModel.Forecast5Days.Forecast.Value) {
        timeLabel.text = viewModel.time
        humidityLabel.text = viewModel.humidity
        tempLabel.text = viewModel.temp
    }
}
