//
//  StorageManager.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    private init() {}
    
    @discardableResult
    func uploadProfilePicture(user: User, imageData: Data?) async throws -> Bool {
        guard let data = imageData else {return false}
        storage.child(user.username).child("profile_picture.png").putData(data)
        return true
    }
    
    func downloadProfilePicture(user: User) async throws -> URL? {
        return try await storage.child(user.username).child("profile_picture.png").downloadURL()
    }
    
}
