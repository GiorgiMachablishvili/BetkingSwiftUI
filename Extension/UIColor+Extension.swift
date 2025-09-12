//
//  UIColor+Extension.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}

// Usage
extension Color {
    static let blueColor = Color(hex: "#2B2B8B")

    static let grayColor = Color(hex: "#7A7A81")

    static let durkBlueColor = Color(hex: "#191D68")

    static let backViewColor = Color(hex: "#111448")

    static let blackShadowColor = Color(hex: "#0A140B")

    static let whiteColor = Color(hex: "#F4F4F4")

    static let blackColorTitle = Color(hex: "#0C102E99")

    static let yellowColorTitle = Color(hex: "#FFDB20")

}
