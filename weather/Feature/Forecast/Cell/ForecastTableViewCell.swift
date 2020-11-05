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
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Data
    static let identifier = "ForecastTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = .white
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

        timeLabel.text = ""
        tempLabel.text = ""
        weatherImageView.image = UIImage()
        descriptionLabel.text = ""
    }
    
    func setCell(viewModel: ForecastViewModel.Forecast5Days.Forecast.Value) {
        timeLabel.text = viewModel.time
        tempLabel.text = viewModel.tempMaxMin
        weatherImageView.downloaded(from: viewModel.weathericonURL)
        descriptionLabel.text = viewModel.weatherDescription
    }
}
