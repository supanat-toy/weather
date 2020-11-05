//
//  LoadingView.swift
//  weather
//
//  Created by Supanat on 3/11/2563 BE.
//

import UIKit

class LoadingView: UIView {

    // MARK: UI
    @objc @IBOutlet weak var containerView: UIView!
    @objc @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @objc @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Data
    static let identifier = "LoadingView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        blurEffectView.alpha = 0.60
        
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = 10
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
