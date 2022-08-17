//
//  PostCollectionViewCell.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/13/22.
//

import UIKit

class PostPostCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties
    static let identifier = "PostPostCollectionViewCell"
    
//MARK: - SubViews
    
    private let nameLabel: CustomLabel = {
        let label = CustomLabel()
        label.tintColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let postBody: CustomLabel = {
        let label = CustomLabel()
        label.tintColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
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
        nameLabel.sizeToFit()
        postBody.sizeToFit()
        nameLabel.frame = CGRect(x: 10, y: 5, width: width, height: nameLabel.height)
        postBody.frame = CGRect(x: 10, y: nameLabel.height + 40, width: width, height: postBody.height)
    }
    
    private func addSubviews() {
        addSubview(postBody)
        addSubview(nameLabel)
    }
    
//MARK: - Configure
    func configure(with viewModel: PostPostViewModel) {
        self.nameLabel.text = viewModel.name
        self.postBody.text = viewModel.body
    }
}

