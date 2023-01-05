//
//  ProfileView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm: ProfileViewModel = ProfileViewModel()
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
            .background(Color.palette.indigo).cornerRadius(12)
            .padding()
            .position(x: geo.frame(in: .local).midX,
                      y: geo.frame(in: .local).midY)
            .animation(.linear(duration: 0.17).delay(0.22))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.lead)
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
            .background(Color.palette.indigo)
    }
    private var usernameSubView: some View {
        TextField("email", text: $vm.authFields.username)
            .font(.headline)
            .foregroundColor(Color.palette.mercury)
            .padding()
            .background(Color.palette.lead)
            .cornerRadius(13)
    }
    private var passwordSubView: some View {
        SecureField("password", text: $vm.authFields.password)
            .font(.headline)
            .foregroundColor(Color.palette.mercury)
            .padding()
            .background(Color.palette.lead)
            .cornerRadius(13)
    }
    @ViewBuilder private var confirmPasswordSubView: some View {
        if vm.selectedAuthMethod == .signup {
            SecureField("confirm password", text: $vm.authFields.confirmPassword)
                .font(.headline)
                .foregroundColor(Color.palette.mercury)
                .padding()
                .background(Color.palette.lead)
                .cornerRadius(13)
        }
    }
    private var authMethodPickerSubView: some View {
        Picker("", selection: $vm.selectedAuthMethod) {
            Text(AuthMethod.signin.rawValue).tag(AuthMethod.signin)
            Text(AuthMethod.signup.rawValue).tag(AuthMethod.signup)
        }
        .pickerStyle(.segmented)
        .frame(width: 150)
    }
    @ViewBuilder private var authButtonSubView: some View {
        if vm.authFieldsIsValidity {
            Button(action: {
                vm.authUserWithEscaping()
//                vm.authUserWithAsync()
                vm.signOut()
            }, label: {
                Image(systemName: "arrowshape.right.fill")
                    .foregroundColor(Color.palette.mercury)
            })
        }
    }
}
