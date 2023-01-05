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
    
    var authFieldsIsValidity: Bool {
        guard !authFields.username.isEmpty,
              !authFields.password.isEmpty
        else { return false }
        switch selectedAuthMethod {
        case .signin:
            return true
        case .signup:
            guard authFields.confirmPassword == authFields.password
            else { return false }
            return true
        }
    }
    
    // MARK: with @escaping
    // auth user with @escaping
    func authUserWithEscaping() {
        guard authFieldsIsValidity else { return }
        switch selectedAuthMethod {
        case .signin:
            signInWithEscaping(email: authFields.username, password: authFields.password)
        case .signup:
            signUpWithEscaping(email: authFields.username, password: authFields.password)
        }
    }
    
    // sign in user with @escaping
    private func signInWithEscaping(email: String, password: String) {
        userDataService.signInUserWithEscaping(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print("\(user.email ?? "") : successfully logged.")
                self.user = user
            case .failure(let error):
                print("\(email) : sign in error : \(error.localizedDescription)")
            }
        }
    }
    
    // sign up user with @escaping
    private func signUpWithEscaping(email: String, password: String) {
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
    
    // MARK: with async
    // auth user with async
    func authUserWithAsync() {
        guard authFieldsIsValidity else { return }
        switch selectedAuthMethod {
        case .signin:
            signInWithAsync(email: authFields.username, password: authFields.password)
        case .signup:
            signUpWithAsync(email: authFields.username, password: authFields.password)
        }
    }
    
    // sign in user with async
    private func signInWithAsync(email: String, password: String) {
        Task {
            self.user = await userDataService.signInWithAsync(email: email, password: password)
        }
    }
    
    // sign up user with async
    private func signUpWithAsync(email: String, password: String) {
        Task {
            self.user = await userDataService.signUpWithAsync(email: email,password: password)
        }
    }
    
    // sign out user
    func signOut() {
        userDataService.signOut()
    }
}
