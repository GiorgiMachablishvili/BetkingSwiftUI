//
//  BetkingSwiftUIApp.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 25.07.25.
//


import SwiftUI

@main
struct BetkingSwiftUIApp: App {
    @StateObject private var authStore = AuthStore()
    @StateObject private var workoutStore = WorkoutStore() // your existing store

    var body: some Scene {
        WindowGroup {
            Group {
                if authStore.isSignedIn || authStore.isGuest {
                    // Main UI (your dashboard)
                    WorkoutDetailView(initialTab: .home)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .navigationBar)
                } else {
                    ContentView()
                }
            }
            .environmentObject(authStore)
            .environmentObject(workoutStore)
        }
    }
}



