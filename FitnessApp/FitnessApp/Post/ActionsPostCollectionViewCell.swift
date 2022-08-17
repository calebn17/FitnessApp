//
//  ActionsPostCollectionViewCell.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/14/22.
//

import UIKit

class ActionsPostCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties
    static let identifier = "ActionsPostCollectionViewCell"
    
//MARK: - SubViews
    private let likeButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        return button
    }()
    
    private let commentButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        return button
    }()
    
    private let shareButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal) 
        return button
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
        likeButton.frame = CGRect(x: 0, y: 0, width: width/3, height: height)
        commentButton.frame = CGRect(x: likeButton.width, y: 0, width: width/3, height: height)
        shareButton.frame = CGRect(x: likeButton.width + commentButton.width, y: 0, width: width/3, height: height)
    }
    
    private func addSubviews() {
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
    }
    
//MARK: - Configure
    func configure(with viewModel: ActionsPostViewModel) {
        let actions = viewModel.actionsTaken
        
        if actions.contains(.liked) { likeButton.tintColor = .systemRed }
        if actions.contains(.commented) { commentButton.tintColor = .systemCyan }
        if actions.contains(.shared) { shareButton.tintColor = .systemGreen }
    }
}
