//
//  LikesPostCollectionViewCell.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/13/22.
//

import UIKit

class LikesPostCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties
    static let identifier = "LikesPostCollectionViewCell"
    
//MARK: - SubViews
    private let likesCountLabel: CustomLabel = {
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
        likesCountLabel.sizeToFit()
        likesCountLabel.frame = CGRect(x: 10, y: 15, width: likesCountLabel.width, height: likesCountLabel.height)
    }
    
    private func addSubviews() {
        addSubview(likesCountLabel)
    }
    
//MARK: - Configure
    func configure(with viewModel: LikesPostViewModel) {
        self.likesCountLabel.text = "\(viewModel.likers.count) likes"
    }
}
