//
//  AddPostRunView.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/15/22.
//

import UIKit

//MARK: - Protocol
protocol AddPostRunViewDelegate: AnyObject {
    func didTapSaveButton(_ view: AddPostRunView)
}

class AddPostRunView: UIView {

//MARK: - Properties
    weak var delegate: AddPostRunViewDelegate?
    
//MARK: - SubViews
    public let nameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter the name of your run..."
        field.keyboardType = .default
        field.returnKeyType = .next
        return field
    }()
    
    public let distanceField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "How far did you run..."
        field.keyboardType = .numberPad
        field.returnKeyType = .next
        return field
    }()
    
    public let durationField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "How long did it take...(minutes)"
        field.keyboardType = .numberPad
        field.returnKeyType = .done
        return field
    }()
    
    private let saveButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureConstraints()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        addSubview(nameField)
        addSubview(distanceField)
        addSubview(durationField)
        addSubview(saveButton)
    }
    
    private func addActions() {
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
//MARK: - Actions
    @objc private func didTapSave() {
        delegate?.didTapSaveButton(self)
    }
}

extension AddPostRunView {
    private func configureConstraints() {
        let nameFieldConstraints = [
            nameField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameField.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            nameField.widthAnchor.constraint(equalToConstant: width - 20),
            nameField.heightAnchor.constraint(equalToConstant: 40)
        ]
        let distanceFieldConstraints = [
            distanceField.centerXAnchor.constraint(equalTo: centerXAnchor),
            distanceField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            distanceField.widthAnchor.constraint(equalToConstant: width - 20),
            distanceField.heightAnchor.constraint(equalToConstant: 40)
        ]
        let durationFieldConstraints = [
            durationField.centerXAnchor.constraint(equalTo: centerXAnchor),
            durationField.topAnchor.constraint(equalTo: distanceField.bottomAnchor, constant: 20),
            durationField.widthAnchor.constraint(equalToConstant: width - 20),
            durationField.heightAnchor.constraint(equalToConstant: 40)
        ]
        let saveButtonConstraints = [
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: durationField.bottomAnchor, constant: 60),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(nameFieldConstraints)
        NSLayoutConstraint.activate(distanceFieldConstraints)
        NSLayoutConstraint.activate(durationFieldConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
}
