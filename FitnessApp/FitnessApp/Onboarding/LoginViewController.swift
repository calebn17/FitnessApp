//
//  LoginViewController.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
//MARK: - Properties
    weak var coordinator: OnboardingCoordinator?
    
//MARK: - SubViews
    private let emailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your Email address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        return field
    }()
    
    private let passwordField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your Password"
        field.keyboardType = .default
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? Register here!", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSubviews()
        configureConstraints()
        addActions()
    }
    
    private func configureSubviews() {
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        emailField.delegate = self
        passwordField.delegate = self
    }
    
//MARK: - Configure
    private func addActions() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterHere), for: .touchUpInside)
    }
    
//MARK: - Actions
    @objc private func didTapLogin() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              email.contains("@"), email.contains(".com"),
              password.count > 4
        else {return}
        
        Task {
            try await OnboardingViewModel.loginUser(email: email.lowercased(), password: password.lowercased())
            coordinator?.dismissLogin(sender: self)
        }
    }
    
    @objc private func didTapRegisterHere() {
        coordinator?.presentRegister(sender: self)
    }
}

//MARK: - RegisterVC Methods
extension LoginViewController: RegisterViewControllerDelegate {
    func didTapRegisterButton(_ sender: RegisterViewController, user: User, password: String) {
        coordinator?.dismissLogin(sender: self)
        Task {
            try await OnboardingViewModel.registerUser(user: user, password: password)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else {
            didTapLogin()
        }
        return true
    }
}

extension LoginViewController {
    private func configureConstraints() {
        let emailFieldConstraints = [
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            emailField.widthAnchor.constraint(equalToConstant: 350)
        ]
        let passwordFieldConstraints = [
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.widthAnchor.constraint(equalToConstant: 350)
        ]
        let loginButtonConstraints = [
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 35),
            loginButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        let registerButtonConstraints = [
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            registerButton.heightAnchor.constraint(equalToConstant: 35),
            registerButton.widthAnchor.constraint(equalToConstant: 350)
        ]
        NSLayoutConstraint.activate(emailFieldConstraints)
        NSLayoutConstraint.activate(passwordFieldConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
    }
}
