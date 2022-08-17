//
//  ProfileViewModel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation

struct ProfileViewModel {
    
    var currentUser: User { return DatabaseManager.shared.currentUser }
}
