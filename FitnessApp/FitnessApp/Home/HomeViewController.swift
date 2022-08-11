//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

final class HomeViewController: UIViewController {
    weak var coordinator: HomeCoordinator?
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        handleIsAuthenticated()
    }
    
    private func handleIsAuthenticated() {
        if viewModel.isNotAuthenticated {
            coordinator?.presentLogin(sender: self)
        }
    }
    

}
