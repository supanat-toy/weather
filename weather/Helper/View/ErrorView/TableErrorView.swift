//
//  NoContentView.swift
//  orcsoft-workshop-election-app
//
//  Created by Supanat Toy on 18/6/2562 BE.
//  Copyright © 2562 Supanat Toy. All rights reserved.
//

import UIKit

class TableErrorView: UIView {
    
    // MARK: UI
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var addButtonAction: (() -> Void)?
    var isEnable: Bool = false
    
    // MARK: Data
    static let identifier = "TableErrorView"
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 3
        
        imageView.layer.cornerRadius = (imageView.frame.height / 2.0) + 30
    }
    
    func setView(title: String, subTitle: String, image: UIImage?) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        imageView.image = image
    }
}

