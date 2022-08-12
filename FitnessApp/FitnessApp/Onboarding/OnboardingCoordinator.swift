//
//  OnboardingCoordinator.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import UIKit

final class OnboardingCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var sender: UIViewController
    
    init(navigationController: UINavigationController, sender: UIViewController) {
        self.navigationController = navigationController
        self.sender = sender
    }
    
    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true)
    }
    
//MARK: - Login Methods
    
    func presentRegister(sender: LoginViewController) {
        let vc = RegisterViewController()
        vc.coordinator = self
        vc.delegate = sender
        let navVC = UINavigationController(rootViewController: vc)
        sender.present(navVC, animated: true)
    }
    
    func dismissLogin(sender: LoginViewController) {
        sender.dismiss(animated: true)
    }
    
    func presentError(sender: LoginViewController) {
        let alert = UIAlertController(
            title: "Oops!",
            message: "Something went wrong. \nMake sure to fill out all the fields",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        sender.present(alert, animated: true)
    }
    
//MARK: - Register Methods
    func dismissRegister(sender: RegisterViewController) {
        sender.dismiss(animated: true)
    }
    
    func presentImagePicker(sender: RegisterViewController) {
        let sheet = UIAlertController(title: "Select your profile picture", message: "Choose how to select your profile picture", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { _ in
            Task {
                await OnboardingViewModel.takePhotoOption(sender: sender)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Choose photo", style: .default, handler: { _ in
            Task {
                await OnboardingViewModel.choosePhotoOption(sender: sender)
            }
        }))
        sender.present(sheet, animated: true)
    }
    
    func presentError(sender: RegisterViewController) {
        let alert = UIAlertController(
            title: "Oops!",
            message: "Something went wrong. \nMake sure to fill out all the fields and select a profile picture",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        sender.present(alert, animated: true)
    }
}
