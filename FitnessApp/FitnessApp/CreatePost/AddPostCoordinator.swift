//
//  AddPostCoordinator.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/15/22.
//

import Foundation
import UIKit

final class AddPostCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var sender: UIViewController
    var postType: PostType
    
    init(navigationController: UINavigationController, sender: UIViewController, postType: PostType) {
        self.navigationController = navigationController
        self.sender = sender
        self.postType = postType
    }
    
    func start() {
        let vc = AddPostViewController(postType: postType)
        vc.coordinator = self
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationItem.backButtonDisplayMode = .minimal
        vc.title = "Create Post"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popVC(sender: AddPostViewController) {
        navigationController.popToRootViewController(animated: true)
    }
}

extension AddPostCoordinator: UINavigationControllerDelegate {
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
        
//        if let loginVC = fromViewController as? LoginViewController {
//            childDidFinish(loginVC.coordinator)
//        }
       
    }
}

