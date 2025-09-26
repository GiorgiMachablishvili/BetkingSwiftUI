//
//  DurationFormatting.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 24.09.25.
//

import Foundation

// Seconds -> "mm:ss"
func formatMMSS(fromSeconds seconds: Int) -> String {
    let m = seconds / 60
    let s = seconds % 60
    return String(format: "%02d:%02d", m, s)
}

// Accept "5" (seconds) or legacy "mm:ss" and return total seconds
func normalizeSeconds(from text: String) -> Int {
    let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmed.contains(":") {
        let parts = trimmed.split(separator: ":").map(String.init)
        let mm = Int(parts.first ?? "0") ?? 0
        let ss = Int(parts.dropFirst().first ?? "0") ?? 0
        return max(0, mm * 60 + ss)
    } else {
        return max(0, Int(trimmed) ?? 0)
    }
}

extension Workout {
    /// Display-ready "mm:ss"
    var durationDisplay: String {
        formatMMSS(fromSeconds: normalizeSeconds(from: duration))
    }
}

