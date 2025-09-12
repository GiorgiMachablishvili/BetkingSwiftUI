//
//  SettingsRow.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 31.08.25.
//

import SwiftUI

struct SettingsRow: View {
    enum LeftIcon {
        case asset(String)      // e.g., .asset("termOfUsIcon")
        case system(String)     // e.g., .system("lock.doc.fill")
    }

    let title: String
    var leftIcon: LeftIcon? = nil
    var background: Color = Color.durkBlueColor
    var titleColor: Color = .white
    var showChevron: Bool = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(background)
                    .frame(height: 64)

                HStack(spacing: 12) {
                    // Left icon (optional)
                    if let leftIcon {
                        Group {
                            switch leftIcon {
                            case .asset(let name):
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                            case .system(let name):
                                Image(systemName: name)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 32, height: 32)
                    }

                    // Title
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(titleColor)

                    Spacer()

                    // Right chevron
                    if showChevron {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .padding(.horizontal, 20) // 20pt on both sides
            }
        }
        .buttonStyle(.plain)
    }
}
