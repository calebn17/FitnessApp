//
//  CustomView.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

class CustomImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.masksToBounds = true
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
