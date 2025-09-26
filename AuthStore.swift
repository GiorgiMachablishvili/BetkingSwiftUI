//
//  SwiftUIView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 24.09.25.
//

// AuthStore.swift
import SwiftUI

final class AuthStore: ObservableObject {
    @Published var isSignedIn = false
    @Published var isGuest = false
    @Published var userId: String?
    @Published var accessToken: String?   // if your backend issues one

    func signOut() {
        isSignedIn = false
        isGuest = false
        userId = nil
        accessToken = nil
    }
}


