//
//  DashboardSummaryMonthCollectionViewCell.swift
//  DealerDashboard
//
//  Created by Supanat on 3/11/2563 BE.
//

import UIKit

class ForecastTableViewHeaderCell: UITableViewHeaderFooterView {

    // MARK: UI
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Data
    static let identifier = "ForecastTableViewHeaderCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
        self.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
    
    func setCell(title: String) {
        titleLabel.text = title
    }
}
