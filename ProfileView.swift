//
//  ProfileView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI

struct ProfileView: View {

    var body: some View {
        VStack(spacing: 20) {
            // Top header
            ZStack {
                Rectangle()
                    .fill(Color.blueColor)
                    .frame(width: .infinity, height: 103)
                    .cornerRadius(20)

                Text("PROFILE")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)
            }

            VStack(spacing: 4) {
                SettingsRow(
                    title: "Terms of use",
                    leftIcon: .asset("termOfUsIcon")
                ) {
                    print("Terms of use tapped")
                }

                SettingsRow(
                    title: "Privacy policy",
                    leftIcon: .asset("privacyPolicy")
                ) {
                    print("Privacy policy tapped")
                }

                SettingsRow(
                    title: "Support",
                    leftIcon: .asset("support")
                ) {
                    print("pressed Support")
                }

                SettingsRow(
                    title: "Rate US",
                    leftIcon: .asset("rateUs")
                ) {
                    print("Logout tapped")
                }

                SettingsRow(
                    title: "Delete Account",
                    leftIcon: nil,
                    background: Color.backViewColor,
                    titleColor: .white,
                    showChevron: true)
                {
                    print("Delete")
                    }

            }

            .padding(.horizontal, 20)

            Spacer()
        }
        .ignoresSafeArea(.all)
        .background(Color.backViewColor.ignoresSafeArea())
    }
}

#Preview {
    ProfileView()
}


//import SwiftUI
//
//struct ProfileView: View {
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                ZStack {
//                    Rectangle()
//                        .fill(Color.blueColor)
//                        .frame(width: .infinity, height: 103)
//                        .cornerRadius(20)
//                    VStack {
//                        Text("Profile".uppercased())
//                            .font(.system(size: 18, weight: .bold))
//                            .foregroundColor(.white)
//                            .padding(.top, 40)
//
//                    }
//                }
//
//                .ignoresSafeArea()
//                Spacer()
//            }
//
//            VStack(spacing: 4) {
//                SettingsRow(
//                    title: "Terms of use",
//                    leftIcon: .asset("termOfUsIcon")
//                ) {
//                    print("Terms of use tapped")
//                }
//
//                SettingsRow(
//                    title: "Privacy policy",
//                    leftIcon: .asset("privacyPolicy")
//                ) {
//                    print("Privacy policy tapped")
//                }
//
//                SettingsRow(
//                    title: "Support",
//                    leftIcon: .asset("support")
//                ) {
//                    print("pressed Support")
//                }
//
//                SettingsRow(
//                    title: "Rate US",
//                    leftIcon: .asset("rateUs")
//                ) {
//                    print("Logout tapped")
//                }
//            }
//
//            .padding(.horizontal, 20)
//
//            Spacer()
//        }
//        .background(Color.backViewColor.ignoresSafeArea())
//    }
//}
//
//#Preview {
//    ProfileView()
//}
