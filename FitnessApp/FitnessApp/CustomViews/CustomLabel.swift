//
//  CustomLabel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/15/22.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        tintColor = .label
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
