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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        timeLabel.text = ""
        tempLabel.text = ""
        weatherImageView.image = UIImage()
        descriptionLabel.text = ""
    }
    
    func setCell(viewModel: ForecastViewModel.Forecast5Days.Forecast.Value?) {
        timeLabel.text = viewModel?.time ?? "N/A"
        tempLabel.text = viewModel?.tempMaxMin ?? "N/A"
        
        if let weathericonURL = viewModel?.weathericonURL {
            weatherImageView.downloaded(from: weathericonURL)
        }
        descriptionLabel.text = viewModel?.weatherDescription ?? "N/A"
    }
}
