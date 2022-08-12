//
//  HomeCoordinator.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import UIKit

final class HomeCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func presentLogin(sender: HomeViewController) {
        let child = OnboardingCoordinator(navigationController: navigationController, sender: sender)
        childCoordinators.append(child)
        child.start()
    }
}

extension HomeCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let loginVC = fromViewController as? LoginViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(loginVC.coordinator)
        }
    }
}

