//
//  ProfileCoordinator.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import UIKit

final class ProfileCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var user: User
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let vc = ProfileViewController()
        vc.title = user.username
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.backButtonDisplayMode = .minimal
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ProfileCoordinator: UINavigationControllerDelegate {
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
