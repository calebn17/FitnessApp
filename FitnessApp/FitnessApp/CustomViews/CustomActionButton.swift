//
//  CustomActionButton.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/15/22.
//

import UIKit

class CustomActionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.cornerRadius = 4
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 1
        tintColor = .label
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
