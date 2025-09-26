//
//  API.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 24.09.25.
//

// API.swift
import Foundation

enum API {
    static let baseURL = "https://your.api.com"            // <— replace
    static let appleSignIn = "\(baseURL)/auth/apple"       // e.g. POST
}

// What your server returns after verifying Apple's id_token
struct SignInResponse: Decodable {
    let accessToken: String
    // add fields as needed (user, refreshToken, etc.)
}

extension String {
    static func userCreate() -> String {
        // TODO: replace with your real endpoint
        return "https://your.api.com/user/create"
    }
}

// Minimal response model; add your fields
struct UserCreateInfo: Decodable {
    let id: String
}
