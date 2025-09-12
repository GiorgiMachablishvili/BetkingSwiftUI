//
//  WorkoutHomeView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI

struct Workout: Identifiable {
    let id: UUID = UUID()
    let title: String
    let workoutType: String
    let duration: String
    let usersCount: Int
    let imageURL: String
    var isFavorite: Bool


    var usersDisplay: String { usersCount > 5 ? "5+" : "\(usersCount)" }

    //    var usersDisplay: String {
    //            if let n = Int(usersCount), n > 5 { return "5+" }
    //            return usersCount
    //        }
}

struct WorkoutHomeView: View {
    @Binding var isRootTabBarVisible: Bool
    @State private var searchText = ""

    @State private var workouts: [Workout] = [
        .init(title: "Full body Burn", workoutType: "run faster run", duration: "00:05", usersCount: 2, imageURL: "fitnessWorkout", isFavorite: true),
        .init(title: "Body Burn", workoutType: "do what can you do as fast as you can, if you do well you will be a pro", duration: "18", usersCount: 4, imageURL: "runWorkout", isFavorite: false),
        .init(title: "Leg day", workoutType: "jump to be good basketball player", duration: "12", usersCount: 7, imageURL: "yogaWorkout", isFavorite: true),
        .init(title: "Run day", workoutType: "run for your life", duration: "24", usersCount: 8, imageURL: "runWorkout", isFavorite: false)
    ]

    private var filteredIndices: [Int] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return Array(workouts.indices) }
        return workouts.indices.filter { workouts[$0].title.lowercased().contains(q) }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                ZStack {
                    Rectangle()
                        .fill(Color.blueColor)
                        .frame(width: .infinity, height: 145)
                        .cornerRadius(20)
                    VStack {
                        Text("WORKOUTS")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 40)

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.7))

                            TextField(
                                "",
                                text: $searchText,
                                prompt: Text("Search for a workout...").foregroundColor(Color.grayColor)
                            )
                            .foregroundColor(Color.grayColor)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color.durkBlueColor)
                        .clipShape(Capsule())
                        .padding(.horizontal, 24)
                    }
                }

                Spacer()

                // List
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], spacing: 24) {
                        ForEach(filteredIndices, id: \.self) { i in
                            NavigationLink {
                                WorkoutsInfoView(
                                    workout: $workouts[i],
                                    isRootTabBarVisible: $isRootTabBarVisible
                                )
                            } label: {
                                WorkoutCard(workout: $workouts[i])
                                    .frame(width: 372, height: 280)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 50)
                }
            }
            .ignoresSafeArea(.all)
            .background(Color.backViewColor.ignoresSafeArea())
        }
    }
}

#Preview {
    WorkoutHomeView(isRootTabBarVisible: .constant(true))
}

private struct WorkoutCard: View {
    @Binding var workout: Workout

    var body: some View {
        ZStack {
            Image(workout.imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 372, height: 280)
                .cornerRadius(24)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.55)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .allowsHitTesting(false)

            VStack() {
                HStack {
                    //Top left conner
                    HStack(spacing: 6) {
                        Image(systemName: "clock.fill")
                            .imageScale(.small)
                        Text("\(workout.duration) min")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(8)
                    .clipShape(Capsule())

                    HStack(spacing: 6) {
                        Image(systemName: "person.2")
                            .imageScale(.small)
                        Text(workout.usersDisplay)
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(8)
                    .clipShape(Capsule())

                    Spacer()

                    Button {
                        workout.isFavorite.toggle()
                    } label: {
                        Image(systemName: workout.isFavorite ? "heart.fill": "heart")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(10)
                            .background(Color.blueColor.opacity(0.6))
                            .clipShape(Circle())
                            .foregroundColor(workout.isFavorite ? .red : .white)
                    }
                    .padding(.top, 12)
                    .padding(.trailing, 12)
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)

                Spacer()

                HStack {
                    ZStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blackShadowColor.opacity(0.6))
                                    .overlay(
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(workout.title)
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.white)
                                                .fixedSize(horizontal: false, vertical: true)

                                            Text(workout.workoutType)
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(.grayColor)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                            .padding(16),
                                        alignment: .topLeading
                                    )
                                    .frame(width: 350)
                                    .frame(maxHeight: 86, alignment: .top)
                                    .clipped()
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}
