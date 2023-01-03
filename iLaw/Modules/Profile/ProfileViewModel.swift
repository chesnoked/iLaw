//
//  ProfileViewModel.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import Foundation
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    
    private let userDataService = UserDataService.shared
    
    @Published var user: User? = nil
    @Published var authFields: AuthFields = AuthFields()
    @Published var selectedAuthMethod: AuthMethod = .signin
    
    // sign up user with escaping
    func signUpWithEscaping(email: String, password: String) {
        userDataService.signUpWithEscaping(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print("\(user.email ?? "") : successfully registered.")
                self.user = user
            case .failure(let error):
                print("\(email) : sign up error : \(error.localizedDescription)")
            }
        }
    }
    
    // sign up user with async
    func signUpWithAsync(email: String, password: String) {
        Task {
            self.user = await userDataService.signUpWithAsync(email: email,password: password)
        }
    }
}
