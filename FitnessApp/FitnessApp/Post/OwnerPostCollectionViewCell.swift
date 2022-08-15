//
//  OwnerPostCollectionViewCell.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/13/22.
//

import UIKit

class OwnerPostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OwnerPostCollectionViewCell"
    
    private let profilePicture: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
}
