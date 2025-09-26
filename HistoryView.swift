//
//  HistoryView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI

struct WorkoutHistoryItem: Identifiable, Hashable {
    let id = UUID()
    let date = Date()
    let title: String
    let workoutType: String
    let duration: String
    let usersCount: Int
    let isFavorite: Bool
}

final class WorkoutHistoryStore: ObservableObject {
    @Published var items: [WorkoutHistoryItem] = []
}

struct HistoryView: View {
    @EnvironmentObject private var history: WorkoutHistoryStore

    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                Rectangle()
                    .fill(Color.blueColor)
                    .frame(width: .infinity, height: 103)
                    .cornerRadius(20)
                VStack {
                    Text("HISTORY")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                }
            }

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(history.items.reversed()) { item in
                        // Card
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.35))
                                .frame(maxWidth: .infinity)
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(item.title)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                    if item.isFavorite {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                    }
                                    Spacer()
                                    Text(item.date.formatted(date: .abbreviated, time: .shortened))
                                        .font(.system(size: 12))
                                        .foregroundColor(.grayColor)
                                }

                                Text(item.workoutType)
                                    .font(.system(size: 14))
                                    .foregroundColor(.grayColor)

                                HStack(spacing: 12) {
                                    label("Duration", item.duration)
                                    label("Players", "\(item.usersCount)")
                                }
                            }
                            .padding(16)
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 24)
            }

            Spacer(minLength: 0)
        }
        .ignoresSafeArea(.all)
        .background(Color.backViewColor.ignoresSafeArea())
    }

    private func label(_ title: String, _ value: String) -> some View {
        HStack(spacing: 6) {
            Text(title + ":")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
            Text(value)
                .font(.system(size: 12))
                .foregroundColor(.grayColor)
        }
    }
}
#Preview {
    HistoryView()
}
