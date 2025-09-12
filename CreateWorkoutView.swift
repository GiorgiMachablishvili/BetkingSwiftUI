//
//  CreateWorkoutView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI

struct CreateWorkoutView: View {
    @State private var name = ""
    @State private var descriptionText = ""
    @State private var timer = ""
    @State private var selectedPlayers = 0
    private let playerOptions = ["1","2","3","4","5+"]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                Rectangle()
                    .fill(Color.blueColor)
                    .frame(width: .infinity, height: 103)
                    .cornerRadius(20)
                VStack {
                    Text("Create a workout".uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                }
            }

            // Content
            ScrollView() {
                VStack(spacing: 16) {
                    photosCard            // 👈 first card
                    detailsCard           // 👈 second card (UNDER the first)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 550)
            }
        }
        .ignoresSafeArea(.all)
        .background(Color.backViewColor.ignoresSafeArea())
    }

    // MARK: - Cards

    private var photosCard: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.durkBlueColor)
            .frame(maxWidth: .infinity, minHeight: 280)
            .shadow(color: Color.blackShadowColor, radius: 40, x: 0, y: 12)
            // centered button
            .overlay(
                Button {
                    print("add image")
                } label: {
                    Image("addPhoto")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }
            )
            .overlay(
                Text("Photos of training")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.grayColor)
                    .padding(.top, 86),
                alignment: .top
            )
    }

    private var detailsCard: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.durkBlueColor.opacity(0.2))
            .shadow(color: Color.blackShadowColor, radius: 40, x: 0, y: 12)
            .overlay(
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    Text("Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)

                    // Name
                    sectionLabel("Name Training")
                    pillTextField(text: $name, placeholder: "Name Training")

                    // Description
                    sectionLabel("Description of the workout")
                    pillTextField(text: $descriptionText, placeholder: "Description of the workout")

                    // Players
                    sectionLabel("How many players can train")
                    playersSelector

                    // Time
                    sectionLabel("Approximate training time")
                    timePill(text: $timer, placeholder: "00:00")
                }
                .padding(10),
                alignment: .topLeading
            )
    }

    // MARK: - Pieces

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.grayColor)
            .padding(.top, 10)
    }

    private func pillTextField(text: Binding<String>, placeholder: String) -> some View {
        TextField(
            "",
            text: text,
            prompt: Text(placeholder).foregroundColor(Color.grayColor)
        )
        .foregroundColor(.white)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .padding(.horizontal, 16)
        .frame(height: 32)
        .frame(maxWidth: .infinity)
        .background(Color.blueColor.opacity(0.35))
        .clipShape(Capsule())
    }

    private var playersSelector: some View {
        HStack(spacing: 4) {
            ForEach(playerOptions.indices, id: \.self) { i in
                Button {
                    selectedPlayers = i
                } label: {
                    Text(playerOptions[i])
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(selectedPlayers == i ? .black : .whiteColor)
                        .frame(width: 66, height: 32)
                        .background(
                            Capsule().fill(selectedPlayers == i ?
                                           Color.yellow : Color.blueColor.opacity(0.35))
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func timePill(text: Binding<String>, placeholder: String) -> some View {
        TextField(
            "",
            text: text,
            prompt: Text(placeholder).foregroundColor(Color.grayColor)
        )
        .foregroundColor(.white)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .padding(.horizontal, 16)
        .frame(height: 32)
        .frame(maxWidth: .infinity)
        .background(Color.blueColor.opacity(0.35))
        .clipShape(Capsule())
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
    }
}

#Preview { CreateWorkoutView() }
