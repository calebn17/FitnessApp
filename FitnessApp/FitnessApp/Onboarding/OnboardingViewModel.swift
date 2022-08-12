//
//  OnboardingViewModel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import UIKit

struct OnboardingViewModel {
    
    static func registerUser(user: User, password: String, imageData: Data?) async throws {
        try await AuthManager.shared.registerNewUser(user: user, password: password)
        try await StorageManager.shared.uploadProfilePicture(user: user, imageData: imageData)
    }
    
    static func loginUser(email: String, password: String) async throws {
        try await AuthManager.shared.loginUser(email: email, password: password)
    }
    
    @MainActor static func takePhotoOption(sender: RegisterViewController) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = sender
        sender.present(picker, animated: true)
    }
    
    @MainActor static func choosePhotoOption(sender: RegisterViewController) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = sender
        sender.present(picker, animated: true)
    }
}
