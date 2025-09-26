//
//  SignInViewModel.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 24.09.25.
//

// SignInViewModel.swift

// SignInViewModel.swift
import SwiftUI
import UIKit
import AuthenticationServices
import Alamofire

final class SignInViewModel: NSObject, ObservableObject,
                             ASAuthorizationControllerDelegate,
                             ASAuthorizationControllerPresentationContextProviding {

    @Published var isLoading = false
    @Published var errorMessage: String?

    private weak var authStore: AuthStore?

    // MARK: - Public API

    func startSignInWithApple(authStore: AuthStore) {
        self.authStore = authStore
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    /// Dev helper to mimic your UIKit mocks
    func signInWithMocks(authStore: AuthStore) {
        self.authStore = authStore
        UserDefaults.standard.setValue("mockPushToken", forKey: "PushToken")
        UserDefaults.standard.setValue("mockAppleToken", forKey: "AccountCredential")
        createUser()
    }

    func logInAsGuest(authStore: AuthStore) {
        self.authStore = authStore
        UserDefaults.standard.setValue(true, forKey: "isGuestUser")
        DispatchQueue.main.async {
            authStore.isGuest = true
            authStore.isSignedIn = true
        }
    }

    // MARK: - Backend

    private func createUser() {
        NetworkManager.shared.showProgressHud(true)
        isLoading = true

        let pushToken  = UserDefaults.standard.string(forKey: "PushToken") ?? ""
        let appleToken = UserDefaults.standard.string(forKey: "AccountCredential") ?? ""

        let parameters: [String: Any] = [
            "push_token": pushToken,
            "auth_token": appleToken
        ]

        NetworkManager.shared.post(
            url: .userCreate(),
            parameters: parameters,
            headers: nil
        ) { [weak self] (result: APIResult<UserCreateInfo>) in
            guard let self else { return }
            DispatchQueue.main.async {
                NetworkManager.shared.showProgressHud(false)
                self.isLoading = false
                UserDefaults.standard.setValue(false, forKey: "isGuestUser")
            }

            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(userInfo.id, forKey: "userId")
                    self.authStore?.userId = userInfo.id
                    self.authStore?.isSignedIn = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - ASAuthorizationControllerPresentationContextProviding
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?
                .windows.first(where: { $0.isKeyWindow }) }
            .first ?? ASPresentationAnchor()
    }

    // MARK: - ASAuthorizationControllerDelegate (renamed signatures)
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            DispatchQueue.main.async { self.errorMessage = "Invalid Apple credential." }
            return
        }

        // You stored credential.user previously; here we also try to read id_token
        if let tokenData = credential.identityToken,
           let idToken = String(data: tokenData, encoding: .utf8) {
            UserDefaults.standard.setValue(idToken, forKey: "AccountCredential")
        } else {
            // Fallback to stable identifier if your backend accepts it
            UserDefaults.standard.setValue(credential.user, forKey: "AccountCredential")
        }

        // You can also store push token elsewhere before createUser()
        // UserDefaults.standard.setValue(<yourPushToken>, forKey: "PushToken")

        createUser()
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        let nsError = error as NSError
        if nsError.domain == ASAuthorizationError.errorDomain {
            switch nsError.code {
            case ASAuthorizationError.canceled.rawValue:
                DispatchQueue.main.async { self.errorMessage = nil } // user canceled; no alert
            case ASAuthorizationError.failed.rawValue:
                DispatchQueue.main.async { self.errorMessage = "Sign-In failed. Please try again." }
            case ASAuthorizationError.invalidResponse.rawValue:
                DispatchQueue.main.async { self.errorMessage = "Invalid response from Apple." }
            case ASAuthorizationError.notHandled.rawValue:
                DispatchQueue.main.async { self.errorMessage = "Apple Sign-In not handled." }
            case ASAuthorizationError.unknown.rawValue:
                fallthrough
            default:
                DispatchQueue.main.async { self.errorMessage = "Unknown Apple Sign-In error." }
            }
        } else {
            DispatchQueue.main.async { self.errorMessage = error.localizedDescription }
        }
    }
}


