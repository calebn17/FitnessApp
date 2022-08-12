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
    
    func presentRegister(sender: LoginViewController) {
        let vc = RegisterViewController()
        vc.coordinator = self
        vc.delegate = sender
        let navVC = UINavigationController(rootViewController: vc)
        sender.present(navVC, animated: true)
    }
    
    func dismissRegister(sender: RegisterViewController) {
        sender.dismiss(animated: true)
    }
    
    func dismissLogin(sender: LoginViewController) {
        sender.dismiss(animated: true)
    }
}

extension OnboardingCoordinator: UINavigationControllerDelegate {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a profile view controller
        if let _ = fromViewController as? ProfileViewController {
            // We're popping a buy view controller; end its coordinator
            //childDidFinish(profileVC.coordinator)
        }
    }
}
