//
//  SettingsCoordinator.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

final class SettingsCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SettingsViewController()
        vc.coordinator = self
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.backButtonDisplayMode = .minimal
        navigationController.pushViewController(vc, animated: true)
    }
    
    @MainActor func presentLogin(sender: SettingsViewController) {
        let child = OnboardingCoordinator(navigationController: navigationController, sender: sender)
        childCoordinators.append(child)
        child.start()
    }
    
    func presentLogOutSheet(sender: SettingsViewController) {
        let sheet = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {[weak sender] _ in
            guard let strongSender = sender else {return}
            Task {
                try await SettingsViewModel.logOut()
                await self.presentLogin(sender: strongSender)
            }
        }))
        sender.present(sheet, animated: true)
    }
}

extension SettingsCoordinator: UINavigationControllerDelegate {
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
    }
}
