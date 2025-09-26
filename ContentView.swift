//
//  ContentView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 25.07.25.
//

import SwiftUI
import AuthenticationServices

// MARK: - ContentView
struct ContentView: View {
    @EnvironmentObject private var authStore: AuthStore
    @StateObject private var vm = SignInViewModel()

    @State private var isGuestActive = false
    @State private var showError = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("signInBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                signInLabel

                // Bottom buttons
                SignInButtonsView(
                    isGuestActive: $isGuestActive,
                    onAppleSignIn: { vm.startSignInWithApple(authStore: authStore) },
                    onGuest: { vm.logInAsGuest(authStore: authStore) }
                )
            }
            .onChange(of: vm.errorMessage) { err in
                showError = (err != nil)
            }
            .navigationDestination(isPresented: $isGuestActive) {
                WorkoutDetailView()
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .navigationBar)
            }
            .alert("Sign In Failed", isPresented: $showError) {
                Button("OK", role: .cancel) { vm.errorMessage = nil }
            } message: {
                Text(vm.errorMessage ?? "Unknown error")
            }
        }
    }

    var signInLabel: some View {
        VStack {
            VStack(spacing: 4) {
                Text("Sign In")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)

                Text("Quickly and securely sign in to the app via Apple")
                    .frame(width: 300)
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 350, height: 103)
                    .foregroundStyle(.black.opacity(0.4))
            )
        }
    }
}

// MARK: - Bottom buttons (renamed to avoid conflict with SwiftUI.ButtonStyle)
struct SignInButtonsView: View {
    @Binding var isGuestActive: Bool
    let onAppleSignIn: () -> Void
    let onGuest: () -> Void

    var body: some View {
        VStack {
            Spacer()

            // Apple Sign In
            Button(action: onAppleSignIn) {
                HStack {
                    Image(systemName: "apple.logo").foregroundColor(.black)
                    Text("Sign in with Apple")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 32)
            }

            // Guest
            Button(action: {
                onGuest()
                isGuestActive = true   // keep your existing NavigationDestination flow
            }) {
                Text("I am Guest")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 32)
            }
            .padding(.bottom, 44)
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(AuthStore())
}
