//
//  TimePostCollectionViewCell.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/13/22.
//

import UIKit

class TimePostCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties
    static let identifier = "TimePostCollectionViewCell"
    
//MARK: - Subviews
    private let timeStampLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .secondaryLabel
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
        timeStampLabel.sizeToFit()
        timeStampLabel.frame = CGRect(x: 10, y: 5, width: timeStampLabel.width, height: timeStampLabel.height)
    }
    
    private func addSubviews() {
        addSubview(timeStampLabel)
    }

//MARK: - Configure
    func configure(with viewModel: TimestampPostViewModel) {
        self.timeStampLabel.text = viewModel.dateCreatedString
    }
}
