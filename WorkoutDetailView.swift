//
//  WorkoutDetailView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 28.07.25.
//

import SwiftUI

struct WorkoutDetailView: View {
    init(initialTab: AppTab = .home) {
        _selectedTab = State(initialValue: initialTab)
    }

    @State private var selectedTab: AppTab
    @State private var isRootTabBarVisible = true

    @StateObject private var workoutStore = WorkoutStore()
    @StateObject private var createVM = CreateWorkoutViewModel()
    @StateObject private var historyStore = WorkoutHistoryStore()

    var body: some View {
        Group {
            switch selectedTab {
            case .home:
                WorkoutHomeView(isRootTabBarVisible: $isRootTabBarVisible)
                    .environmentObject(workoutStore)
            case .favorites:
                FavoritesView()
            case .add:
                CreateWorkoutView(vm: createVM)
                    .environmentObject(workoutStore)
            case .library:
                HistoryView()
            case .profile:
                ProfileView()
            }
        }
        .background(Color.backViewColor.ignoresSafeArea())
        .environmentObject(historyStore)
        .safeAreaInset(edge: .bottom) {
            if isRootTabBarVisible {
                if selectedTab == .add {
                    CreateModeTabBar(
                        onBack: { selectedTab = .home },
                        onAction: {
                            if let w = createVM.buildWorkout() {
                                workoutStore.workouts.insert(w, at: 0)
                                if let img = createVM.selectedImage {
                                    workoutStore.images[w.id] = img
                                }
                                createVM.reset()
                                selectedTab = .home    // 👈 navigate to Home
                            } else {
                                print("Please enter a workout name.")
                            }
                        },
                        actionTitle: "Public"
                    )
                } else {
                    CustomTabBarView(selected: $selectedTab) { }
                }
            }
        }
    }
}


#Preview {
    WorkoutDetailView()
}

