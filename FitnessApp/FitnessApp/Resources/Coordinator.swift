//
//  Coordinator.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set}
    var navigationController: UINavigationController { get set }
    
    func start()
}
