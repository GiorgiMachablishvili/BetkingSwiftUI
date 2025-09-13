//
//  WorkoutsInfoView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 08.09.25.
//

import SwiftUI

struct WorkoutsInfoView: View {
    @Binding var workout: Workout
    @Binding var isRootTabBarVisible: Bool
    @State private var selectedTab: AppTab = .home
    @Environment(\.dismiss) private var dismiss

    @State private var goToTimer = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image(workout.imageURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 374, height: 280)
                        .cornerRadius(35)
                        .clipped()
                        .padding(.trailing)

                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.35)]),
                        startPoint: .center, endPoint: .bottom
                    )
                    .allowsHitTesting(false)



                    Button {
                        workout.isFavorite.toggle()
                    } label: {
                        Image(systemName: workout.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(12)
                            .background(Color.blueColor.opacity(0.7))
                            .clipShape(Circle())
                            .foregroundColor(workout.isFavorite ? .red : .white)
                            .padding(.top, 16)
                            .padding(.trailing, 20)
                    }
                    .buttonStyle(.plain)
                }

                .padding(.bottom, 8)

                ZStack (alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.35))
                        .frame(width: 374)
                        .frame(minHeight: 100)

                    VStack(alignment: .leading) {
                        Text(workout.title)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)

                        Text(workout.workoutType)
                            .font(.system(size: 16))
                            .foregroundColor(.grayColor)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                }

                HStack {
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.35))
                            .frame(width: 183, height: 74)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Training time")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)

                            Text(workout.duration)
                                .font(.system(size: 12))
                                .foregroundColor(.grayColor)
                        }
                        .padding(16)
                    }

                    Spacer()

                    ZStack (alignment: .topLeading){
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.35))
                            .frame(width: 183, height: 74)

                        VStack (alignment: .leading, spacing: 4) {
                            Text("Number of players")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)

                            Text( "\(workout.usersCount)")
                                .font(.system(size: 12))
                                .foregroundColor(.grayColor)
                        }
                        .padding(16)
                    }
                }
                .padding()
            }
        }
        .background(Color.backViewColor.ignoresSafeArea())
        .onAppear { isRootTabBarVisible = false }    // 👈 hide parent
        .navigationBarTitleDisplayMode(.inline)
        .background(
            NavigationLink(isActive: $goToTimer) {
                WorkoutTimerView(
                    workout: $workout,
                    isRootTabBarVisible: $isRootTabBarVisible,
                    onFinished: {
                        isRootTabBarVisible = true     // we’re going back to Home -> show parent bar
                        goToTimer = false              // pop Timer
                        DispatchQueue.main.async {     // then pop Info
                            dismiss()
                        }
                    }
                )
            } label: { EmptyView() }
            .hidden()
        )
        .onAppear { isRootTabBarVisible = false }
        .safeAreaInset(edge: .bottom) {
            CreateModeTabBar(
                onBack: {
                            isRootTabBarVisible = false
                            dismiss()
                        },
                onAction: { goToTimer = true },
                actionTitle: "Start"
            )
        }
    }
}

#Preview {
    WorkoutsInfoView(
        workout: .constant(
            Workout(title: "Full body Burn", workoutType: "...", duration: "35", usersCount: 7, imageURL: "fitnessWorkout", isFavorite: true)
        ),
        isRootTabBarVisible: .constant(false)
    )
}


