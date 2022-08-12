//
//  SettingsViewModel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import UIKit

struct SettingsSection {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let image: UIImage?
    let color: UIColor
    let handler: (() -> Void)?
}

struct SettingsViewModel {
    
    static let sections: [SettingsSection] = [
        SettingsSection(
            title: "Account",
            options: [
                SettingsOption(
                    title: "Account Information",
                    image: nil,
                    color: .label,
                    handler: nil
                )
            ]
        ),
        SettingsSection(
            title: "Preferences",
            options: [
                SettingsOption(
                    title: "Units of Measurement",
                    image: nil,
                    color: .label,
                    handler: nil
                )
            ]
        )
    ]
    
    static func logOut() async throws {
        try await AuthManager.shared.logoutUser()
    }
}
