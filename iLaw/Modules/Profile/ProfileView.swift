//
//  ProfileView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileVM = ProfileViewModel()
    var body: some View {
        ZStack {
            NavBar()
                .frame(maxHeight: .infinity, alignment: .top)
            AuthForm()
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.lead)
    }
}

extension ProfileView {
    private func NavBar() -> some View {
        Text(profileVM.user?.email ?? "Profile")
            .font(.system(size: 42, weight: .black, design: .rounded))
            .foregroundColor(Color.palette.mercury)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.palette.indigo)
            .divider(.bottom)
    }
    private func AuthForm() -> some View {
        VStack(spacing: 10) {
            usernameSubView
            passwordSubView
            confirmPasswordSubView
            authMethodPickerSubView
            authButtonSubView
        }
        .padding()
        .background(Color.palette.indigo).cornerRadius(12)
        .animation(.linear(duration: 0.17).delay(0.22))
    }
}

extension ProfileView {
    private var usernameSubView: some View {
        TextField("email", text: $profileVM.authFields.username)
            .font(.headline)
            .foregroundColor(Color.palette.mercury)
            .padding()
            .background(Color.palette.lead)
            .cornerRadius(13)
    }
    private var passwordSubView: some View {
        SecureField("password", text: $profileVM.authFields.password)
            .font(.headline)
            .foregroundColor(Color.palette.mercury)
            .padding()
            .background(Color.palette.lead)
            .cornerRadius(13)
    }
    @ViewBuilder private var confirmPasswordSubView: some View {
        if profileVM.selectedAuthMethod == .signup {
            SecureField("confirm password", text: $profileVM.authFields.confirmPassword)
                .font(.headline)
                .foregroundColor(Color.palette.mercury)
                .padding()
                .background(Color.palette.lead)
                .cornerRadius(13)
        }
    }
    private var authMethodPickerSubView: some View {
        Picker("", selection: $profileVM.selectedAuthMethod) {
            Text(AuthMethod.signin.rawValue).tag(AuthMethod.signin)
            Text(AuthMethod.signup.rawValue).tag(AuthMethod.signup)
        }
        .pickerStyle(.segmented)
        .frame(width: 150)
    }
    @ViewBuilder private var authButtonSubView: some View {
        if profileVM.authFieldsIsValidity {
            Button(action: {
                profileVM.authUserWithEscaping()
//                vm.authUserWithAsync()
                profileVM.signOut()
            }, label: {
                Image(systemName: "arrowshape.right.fill")
                    .foregroundColor(Color.palette.mercury)
            })
        }
    }
}
