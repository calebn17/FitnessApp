//
//  ActionsPostCollectionViewCell.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/14/22.
//

import UIKit

//MARK: - Protocol
protocol ActionsPostCollectionViewCellDelegate: AnyObject {
    func tappedOnLikeButton(_ cell: ActionsPostCollectionViewCell, viewModel: ActionsPostViewModel, liked: Bool)
    func tappedOnCommentButton(_ cell: ActionsPostCollectionViewCell)
    func tappedOnShareButton(_ cell: ActionsPostCollectionViewCell)
}

class ActionsPostCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties
    static let identifier = "ActionsPostCollectionViewCell"
    weak var delegate: ActionsPostCollectionViewCellDelegate?
    private var viewModel: ActionsPostViewModel?
    private var isLiked: Bool = false
    private var didComment: Bool = false
    private var currentUser: User { return DatabaseManager.shared.currentUser }
    
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
        addActions()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.tintColor = .label
        commentButton.tintColor = .label
        shareButton.tintColor  = .label
    }
    
    private func addSubviews() {
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
    }
    
//MARK: - Configure
    func configure(with viewModel: ActionsPostViewModel) {
        self.viewModel = viewModel
        if viewModel.likers.contains(currentUser.username) {
            isLiked = true
            likeButton.tintColor = .systemRed
        }
    }
    
    private func addActions() {
        likeButton.addTarget(self, action: #selector(didTapOnLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapOnComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapOnShare), for: .touchUpInside)
    }

//MARK: - Actions
    
    @objc private func didTapOnLike() {
        guard let viewModel = viewModel else {return}
        // if the button is already liked, we want to present the unliked state when tapped
        likeButton.tintColor = isLiked ? .label : .systemRed
        //set this property to match state
        isLiked = !isLiked
        delegate?.tappedOnLikeButton(self, viewModel: viewModel, liked: isLiked)
    }
    
    @objc private func didTapOnComment() {
        commentButton.tintColor = didComment ? .label : .systemCyan
        didComment = !didComment
        delegate?.tappedOnCommentButton(self)
    }
    
    @objc private func didTapOnShare() {
        delegate?.tappedOnShareButton(self)
    }
}
