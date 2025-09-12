//
//  WorkoutDetailView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 28.07.25.
//

import SwiftUI

struct WorkoutDetailView: View {
    @State private var searchText = ""
    @State private var selectedTab: AppTab = .home
    @State private var showPlusSheet = false
    @State private var isRootTabBarVisible = true
    @StateObject private var historyStore = WorkoutHistoryStore()

    var body: some View {
        // Content switches with selected tab
        Group {
            switch selectedTab {
            case .home:
                WorkoutHomeView(isRootTabBarVisible: $isRootTabBarVisible)
            case .favorites:
                FavoritesView()
            case .add:
                CreateWorkoutView()
            case .library:
                HistoryView()
            case .profile:
                ProfileView()
            }
        }
        .background(Color.backViewColor.ignoresSafeArea())
        .environmentObject(historyStore)

        // Pin the custom tab bar INSIDE this screen
        .safeAreaInset(edge: .bottom) {
            if isRootTabBarVisible {
                if selectedTab == .add {
                    CreateModeTabBar(
                        onBack: { selectedTab = .home },
                        onAction: { print(">>> Action pressed <<<") },
                        actionTitle: "Public"
                    )
                } else {
                    CustomTabBarView(selected: $selectedTab) { }
                }
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    WorkoutDetailView()
}

