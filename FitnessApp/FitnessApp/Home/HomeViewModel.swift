//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import FirebaseAuth

struct HomeViewModel {
    
    var isNotAuthenticated: Bool {
        Auth.auth().currentUser == nil
    }
}
