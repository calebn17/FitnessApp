//
//  RegisterViewController.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

protocol RegisterViewControllerDelegate: AnyObject {
    func didTapRegisterButton(_ sender: RegisterViewController, user: User, password: String)
}

class RegisterViewController: UIViewController {
    weak var coordinator: OnboardingCoordinator?
    weak var delegate: RegisterViewControllerDelegate?
    
//MARK: - SubViews
    private let imagePickerView: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .label
        imageView.layer.cornerRadius = K.userImageSize*1.5/2
        return imageView
    }()
    
    private let usernameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your username"
        field.keyboardType = .default
        field.returnKeyType = .next
        return field
    }()
    
    private let emailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your email"
        field.keyboardType = .default
        field.returnKeyType = .next
        return field
    }()
    
    private let passwordField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your password"
        field.keyboardType = .default
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Register", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureSubviews()
        configureConstraints()
        addActions()
    }
    
    private func configureSubviews() {
        view.addSubview(imagePickerView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    private func addActions() {
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }

//MARK: - Actions
    @objc private func didTapClose() {
        coordinator?.dismissRegister(sender: self)
    }
    
    @objc private func didTapRegister() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
              let username = usernameField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              email.contains("@"), email.contains(".com"),
              password.count > 4
        else {return}
        
        let user = User(username: username.lowercased(), email: email.lowercased())
        coordinator?.dismissRegister(sender: self)
        delegate?.didTapRegisterButton(self, user: user, password: password.lowercased())
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            usernameField.resignFirstResponder()
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else {
            didTapRegister()
        }
        return true
    }
}

extension RegisterViewController {
    private func configureConstraints() {
        let imagePickerViewConstraints = [
            imagePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imagePickerView.heightAnchor.constraint(equalToConstant: K.userImageSize*1.5),
            imagePickerView.widthAnchor.constraint(equalToConstant: K.userImageSize*1.5)
        ]
        let usernameFieldConstraints = [
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.topAnchor.constraint(equalTo: imagePickerView.bottomAnchor, constant: 20),
            usernameField.heightAnchor.constraint(equalToConstant: 40),
            usernameField.widthAnchor.constraint(equalToConstant: 300)
        ]
        let emailFieldConstraints = [
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            emailField.widthAnchor.constraint(equalToConstant: 300)
        ]
        let passwordFieldConstraints = [
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.widthAnchor.constraint(equalToConstant: 300)
        ]
        let registerButtonConstraints = [
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            registerButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(imagePickerViewConstraints)
        NSLayoutConstraint.activate(usernameFieldConstraints)
        NSLayoutConstraint.activate(emailFieldConstraints)
        NSLayoutConstraint.activate(passwordFieldConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
    }
}

