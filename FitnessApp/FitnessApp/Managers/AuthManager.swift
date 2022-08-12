//
//  AuthManager.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    @discardableResult
    func registerNewUser(user: User, password: String) async throws -> Bool {
        guard try await DatabaseManager.shared.canCreateUser(user: user) else {return false}
        try await Auth.auth().createUser(withEmail: user.email, password: password)
        try await DatabaseManager.shared.insertUser(user: user)
        UserDefaults.standard.set(user.username, forKey: K.username)
        UserDefaults.standard.set(user.email, forKey: K.email)
        return true
    }
    
    @discardableResult
    func loginUser(email: String, password: String) async throws -> Bool {
        try await Auth.auth().signIn(withEmail: email, password: password)
        guard let user = try await DatabaseManager.shared.getUser(email: email) else {return false}
        UserDefaults.standard.set(user.username, forKey: K.username)
        UserDefaults.standard.set(user.email, forKey: K.email)
        return true
    }
    
    func logoutUser() async throws {
        try Auth.auth().signOut()
    }
}
