//
//  OnboardingViewModel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation

struct OnboardingViewModel {
    
    static func registerUser(user: User, password: String) async throws {
        try await AuthManager.shared.registerNewUser(user: user, password: password)
    }
    
    static func loginUser(email: String, password: String) async throws {
        try await AuthManager.shared.loginUser(email: email, password: password)
    }
}
