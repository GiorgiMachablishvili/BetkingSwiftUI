//
//  WorkoutTimerView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 08.09.25.
//

import SwiftUI

struct WorkoutTimerView: View {
    @Binding var workout: Workout
    @Binding var isRootTabBarVisible: Bool
    let onFinished: () -> Void

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var history: WorkoutHistoryStore  // 👈 ADD

    @State private var remainingSeconds: Int = 0
    @State private var isRunning = true
    @State private var didFinishOnce = false

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.backViewColor.ignoresSafeArea()

            VStack {
                // Top card
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.35))
                        .frame(width: 374)
                        .frame(maxHeight: 182)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(workout.title)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)

                        Text(workout.workoutType)
                            .font(.system(size: 16))
                            .foregroundColor(.grayColor)
                    }
                    .padding(12)
                }

                Spacer()

                VStack {
                    Text("Timer")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.whiteColor)

                    Text(formattedTime(remainingSeconds))
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.yellowColorTitle)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, -60)
                Spacer()
            }
        }
        .onAppear {
            remainingSeconds = parseDurationSeconds(workout.duration)
            isRootTabBarVisible = false                 // 👈 hide parent bar here
        }
        .onDisappear {
            isRootTabBarVisible = true                  // 👈 restore when leaving timer
        }
        .onReceive(ticker) { _ in
            guard isRunning, remainingSeconds > 0 else { return }
            remainingSeconds -= 1
            if remainingSeconds == 0 { handleFinish() }   // 👈 done!
        }
        .safeAreaInset(edge: .bottom) {
            CreateModeTabBar(
                onBack: {
                    isRootTabBarVisible = true              // restore when exiting timer
                    dismiss()
                },
                onAction: { isRunning.toggle() },
                actionTitle: isRunning ? "Pause" : "Continue"
            )
        }
    }

    private func handleFinish() {
        guard !didFinishOnce else { return }
        didFinishOnce = true
        isRunning = false

        // Save to history
        history.items.append(
            WorkoutHistoryItem(
                title: workout.title,
                workoutType: workout.workoutType,
                duration: workout.duration,
                usersCount: workout.usersCount,
                isFavorite: workout.isFavorite
            )
        )

        // Navigate Home
        onFinished()
    }

    private func parseDurationSeconds(_ text: String) -> Int {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.contains(":") {
            let parts = trimmed.split(separator: ":").map(String.init)
            let mm = Int(parts.first ?? "0") ?? 0
            let ss = Int(parts.dropFirst().first ?? "0") ?? 0
            return max(0, mm * 60 + ss)
        } else {
            // treat as minutes
            let minutes = Int(trimmed) ?? 0
            return max(0, minutes * 60)
        }
    }

    private func formattedTime(_ totalSeconds: Int) -> String {
        let m = totalSeconds / 60
        let s = totalSeconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}


#Preview {
    WorkoutTimerView(
        workout: .constant(
            Workout(
                title: "Full body Burn",
                workoutType: "do what can you do as fast as you can, if you do well you will be a pro",
                duration: "35",
                usersCount: 7,
                imageURL: "fitnessWorkout",
                isFavorite: true
            )
        ),
        isRootTabBarVisible: .constant(false),
        onFinished: { /* no-op for preview */ }   // ✅ add this
    )
    .environmentObject(WorkoutHistoryStore())      // ✅ needed for @EnvironmentObject
}
