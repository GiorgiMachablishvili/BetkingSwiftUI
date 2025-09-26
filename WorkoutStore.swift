//
//  WorkoutStore.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 24.09.25.
//

import SwiftUI

final class WorkoutStore: ObservableObject {
//    @Published var workouts: [Workout] = []
//    @Published var images: [UUID: UIImage] = [:]

    @Published var workouts: [Workout] = [
        .init(title: "Full body Burn", workoutType: "run faster run", duration: "00:05", usersCount: 2, imageURL: "fitnessWorkout", isFavorite: true),
        .init(title: "Body Burn", workoutType: "do what can you do as fast as you can, if you do well you will be a pro", duration: "00:12", usersCount: 4, imageURL: "runWorkout", isFavorite: false),
        .init(title: "Leg day", workoutType: "jump to be good basketball player", duration: "00:25", usersCount: 7, imageURL: "yogaWorkout", isFavorite: true),
        .init(title: "Run day", workoutType: "run for your life", duration: "00:30", usersCount: 8, imageURL: "runWorkout", isFavorite: false)
    ]

    // Store picked photos here keyed by Workout.id
    @Published var images: [UUID: UIImage] = [:]
}

