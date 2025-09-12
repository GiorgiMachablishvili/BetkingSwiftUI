//
//  CreateModeTabBar.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 31.08.25.
//

import SwiftUI

struct CreateModeTabBar: View {
    var onBack: () -> Void
    var onAction: () -> Void
    var actionTitle: String = "Public"

    private let barHeight: CGFloat = 84

    var body: some View {
        HStack(spacing: 20) {
            // Back (left circle)
            Button(action: onBack) {
                ZStack {
                    Circle()
                        .fill(Color.blueColor.opacity(0.9))
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Back")

            // Start (big yellow pill)
            Button(action: onAction) {
                Text(actionTitle) // 👈 uses parameter
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Capsule().fill(Color.yellow))
            }
            .accessibilityLabel(actionTitle)
        }

        .padding(.horizontal, 20)
        .frame(height: barHeight)
        .frame(maxWidth: 263)
        .background(
            Capsule()
                .fill(Color.blueColor)
        )
        .shadow(radius: 6, y: 2)
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }
}

