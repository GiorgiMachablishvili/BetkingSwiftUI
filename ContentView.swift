//
//  ContentView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 25.07.25.
//

import SwiftUI

struct ContentView: View {

    @State private var isGuestActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("signInBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                signInLabel
//                buttonsView
                ButtonStyle(isGuestActive: $isGuestActive)
            }
            .navigationDestination(isPresented: $isGuestActive) {
                WorkoutDetailView()
            }
        }
    }

    var signInLabel: some View {
        VStack {
            // 👇 Centered Sign In block
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
                    .foregroundStyle(.black).opacity(0.4)
            )
        }
    }

//    var buttonsView: some View {
//        VStack {
//            Spacer()
//            // 👇 Apple Sign In Button
//            Button(action: {
//                print("Sign in with Apple")
//            }) {
//                HStack {
//                    Image(systemName: "apple.logo")
//                        .foregroundColor(.black)
//                    Text("Sign in with Apple")
//                        .font(.system(size: 16,weight: .semibold))
//                        .foregroundColor(.black)
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.white)
//                .cornerRadius(12)
//                .padding(.horizontal, 32)
//            }
//
//            // 👇 Guest Button
//
//            Button(action: {
//                isGuestActive = true
//            }) {
//                Text("I am Guest")
//                    .font(.system(size: 16, weight: .semibold))
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.black.opacity(0.5))
//                    .cornerRadius(12)
//                    .padding(.horizontal, 32)
//            }
//            .padding(.bottom, 44)
//        }
//    }
}

struct ButtonStyle: View {
    @Binding var isGuestActive: Bool

    var body: some View {
        VStack {
            Spacer()
            // 👇 Apple Sign In Button
            Button(action: {
                print("Sign in with Apple")
            }) {
                HStack {
                    Image(systemName: "apple.logo")
                        .foregroundColor(.black)
                    Text("Sign in with Apple")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 32)
            }

            // 👇 Guest Button

            Button(action: {
                isGuestActive = true
            }) {
                Text("I am Guest")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(12)
                    .padding(.horizontal, 32)
            }
            .padding(.bottom, 44)
        }
    }
}

#Preview {
    ContentView()
}


