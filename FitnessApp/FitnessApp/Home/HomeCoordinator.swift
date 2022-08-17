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
        vc.title = "Home"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.backButtonDisplayMode = .minimal
        navigationController.pushViewController(vc, animated: true)
    }

    func presentLogin(sender: HomeViewController) {
        let child = OnboardingCoordinator(navigationController: navigationController, sender: sender)
        childCoordinators.append(child)
        child.start()
    }
    
    @MainActor func pushAddPostVC(sender: HomeViewController) {
        let sheet = UIAlertController(title: "Select one", message: "What type of exercise did you do?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Run", style: .default, handler: {[weak self] _ in
            guard let navVC = self?.navigationController else {return}
            let child = AddPostCoordinator(navigationController: navVC, sender: sender, postType: .run)
            self?.childCoordinators.append(child)
            child.start()
        }))
        sheet.addAction(UIAlertAction(title: "Lift", style: .default, handler: {[weak self] _ in
            guard let navVC = self?.navigationController else {return}
            let child = AddPostCoordinator(navigationController: navVC, sender: sender, postType: .lift)
            self?.childCoordinators.append(child)
            child.start()
        }))
        sheet.addAction(UIAlertAction(title: "Metcon", style: .default, handler: {[weak self] _ in
            guard let navVC = self?.navigationController else {return}
            let child = AddPostCoordinator(navigationController: navVC, sender: sender, postType: .metcon)
            self?.childCoordinators.append(child)
            child.start()
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sender.present(sheet, animated: true)
    }
}

extension HomeCoordinator: UINavigationControllerDelegate {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let loginVC = fromViewController as? LoginViewController {
            childDidFinish(loginVC.coordinator)
        }
        if let addPostVC = fromViewController as? AddPostViewController {
            childDidFinish(addPostVC.coordinator)
        }
    }
}

