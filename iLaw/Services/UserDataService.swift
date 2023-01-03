//
//  UserDataService.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import Foundation
import FirebaseAuth

class UserDataService {
    
    static let shared: UserDataService = UserDataService()
    
    private let auth = Auth.auth()
    
    // sign up
    // sign in
    // sign out
    
    // sign up user with escaping
    func signUpWithEscaping(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard let result = result else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(result.user))
        }
    }
    
    // sign up user with async
    func signUpWithAsync(email: String, password: String) async -> User? {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            return result.user
        } catch let error {
            print("\(email) : sign up error : \(error.localizedDescription)")
            return nil
        }
    }
}
