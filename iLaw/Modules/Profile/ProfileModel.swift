//
//  ProfileModel.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import Foundation

enum AuthMethod: String {
    case signin = "Sign In"
    case signup = "Sign Up"
}

struct AuthFields {
    var username: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}
