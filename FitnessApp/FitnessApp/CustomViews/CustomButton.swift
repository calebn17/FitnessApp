//
//  CustomButton.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        tintColor = .label
        backgroundColor = .systemBackground
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 2
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
