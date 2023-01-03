//
//  ProfileView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm: ProfileViewModel = ProfileViewModel()
    @State private var selectedAuthMethod: AuthMethod = .signin
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    var body: some View {
        GeometryReader { geo in
            navBarSubView
            VStack(spacing: 10) {
                usernameSubView
                passwordSubView
                confirmPasswordSubView
                authMethodPickerSubView
                authButtonSubView
            }
            .padding()
            .position(x: geo.frame(in: .local).midX,
                      y: geo.frame(in: .local).midY)
            .animation(.linear(duration: 0.17).delay(0.22))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.parent)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    private var navBarSubView: some View {
        Text(vm.user?.email ?? "profile".capitalized)
            .font(.system(.largeTitle, design: .rounded, weight: .black))
            .foregroundColor(Color.palette.mercury)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.palette.child)
    }
    private var usernameSubView: some View {
        TextField("email", text: $username)
            .font(.headline)
            .foregroundColor(Color.palette.mercury)
            .padding()
            .background(Color.palette.child)
            .cornerRadius(13)
    }
    private var passwordSubView: some View {
        SecureField("password", text: $password)
            .font(.headline)
            .foregroundColor(Color.palette.mercury)
            .padding()
            .background(Color.palette.child)
            .cornerRadius(13)
    }
    @ViewBuilder private var confirmPasswordSubView: some View {
        if selectedAuthMethod == .signup {
            SecureField("confirm password", text: $confirmPassword)
                .font(.headline)
                .foregroundColor(Color.palette.mercury)
                .padding()
                .background(Color.palette.child)
                .cornerRadius(13)
        }
    }
    private var authMethodPickerSubView: some View {
        Picker("", selection: $selectedAuthMethod) {
            Text(AuthMethod.signin.rawValue).tag(AuthMethod.signin)
            Text(AuthMethod.signup.rawValue).tag(AuthMethod.signup)
        }
        .pickerStyle(.segmented)
        .frame(width: 150)
    }
    private var authButtonSubView: some View {
        Button(action: {
//            vm.signUpWithEscaping(email: username, password: password)
            vm.signUpWithAsync(email: username, password: password)
        }, label: {
            Image(systemName: "arrowshape.right.fill")
                .foregroundColor(Color.palette.mercury)
        })
    }
}
