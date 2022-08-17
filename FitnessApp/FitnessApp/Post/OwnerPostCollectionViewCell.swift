//
//  OwnerPostCollectionViewCell.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/13/22.
//

import UIKit
import SDWebImage

class OwnerPostCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties
    static let identifier = "OwnerPostCollectionViewCell"
    
//MARK: - SubViews
    private let profilePicture: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.image = UIImage(systemName: "person.fill")
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private let usernameLabel: CustomLabel = {
        let label = CustomLabel()
        return label
    }()
    
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        profilePicture.frame = CGRect(x: 10, y: 5, width: 50, height: 50)
        usernameLabel.sizeToFit()
        usernameLabel.frame = CGRect(x: 80, y: 5, width: usernameLabel.width, height: 50)
    }
    
    private func addSubviews() {
        addSubview(profilePicture)
        addSubview(usernameLabel)
    }
    
//MARK: - Configure
    func configure(with viewModel: OwnerPostViewModel) {
        self.usernameLabel.text = viewModel.username
        //self.profilePicture.sd_setImage(with: viewModel.profilePictureURL, completed: nil)
    }
    
}
