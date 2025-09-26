//
//  CreateWorkoutViewModel.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 24.09.25.
//

import SwiftUI
import PhotosUI

final class CreateWorkoutViewModel: ObservableObject {
    @Published var name = ""
    @Published var descriptionText = ""
    @Published var timer = ""                 // "mm" or "mm:ss"
    @Published var selectedPlayersIndex = 0   // default -> "1"
    let playerOptions = ["1","2","3","4","5+"]

    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImage: UIImage? = nil

    func usersCount() -> Int {
        let value = playerOptions[selectedPlayersIndex]
        return value == "5+" ? 6 : (Int(value) ?? 1)
    }

    func buildWorkout() -> Workout? {
        let title = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return nil }

        let seconds = Int(timer) ?? 0   // seconds from the digits-only field

        return Workout(
            title: title,
            workoutType: descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "—" : descriptionText,
            duration: String(seconds),   // store as seconds string
            usersCount: usersCount(),
            imageURL: "",
            isFavorite: false
        )
    }


    func reset() {
        name = ""; descriptionText = ""; timer = ""
        selectedPlayersIndex = 0
        selectedItem = nil; selectedImage = nil
    }
}


