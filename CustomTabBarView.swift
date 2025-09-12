//
//  CustomTabBarView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI

// MARK: - Tabs
enum AppTab: Int {
    case home, favorites, add, library, profile
}

// MARK: - Custom Tab Bar
struct CustomTabBarView: View {
    @Binding var selected: AppTab
    var plusAction: () -> Void = {}

    private let barHeight: CGFloat = 84
    private let sideIconSize: CGFloat = 24
    private let centerSize: CGFloat = 44

    var body: some View {
        HStack(spacing: 20) {
            tabButton(.home, system: "house.fill")
            tabButton(.favorites, system: "heart.fill")

            // Center "+" button
            Button(action: {
                selected = .add
                plusAction()
            }) {
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: centerSize, height: centerSize)
                        .shadow(radius: 4, y: 2)

                    Image(systemName: "plus")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color.black)
                }
            }
            .accessibilityLabel("Add")

            tabButton(.library, system: "book.closed.fill")
            tabButton(.profile, system: "person.fill")
        }
        .padding(.horizontal, 20)
        .frame(height: barHeight)
        .frame(maxWidth: 284)
        .background(
            Capsule()
                .fill(Color.blueColor)            
        )
        .shadow(radius: 6, y: 2)
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }

    // MARK: - Side tab button
    @ViewBuilder
    private func tabButton(_ tab: AppTab, system: String) -> some View {
        Button {
            selected = tab
        } label: {
            Image(systemName: system)
                .font(.system(size: sideIconSize, weight: .semibold))
                .foregroundStyle(iconColor(for: tab))
                .frame(width: 32, height: 32)
        }
        .accessibilityLabel("\(String(describing: tab))")
    }

    private func iconColor(for tab: AppTab) -> Color {
        selected == tab ? .white : .white.opacity(0.35)
    }
}

