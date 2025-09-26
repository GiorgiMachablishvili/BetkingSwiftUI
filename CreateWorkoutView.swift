//
//  CreateWorkoutView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI
import PhotosUI

struct CreateWorkoutView: View {
    @State private var name = ""
    @State private var descriptionText = ""
    @State private var timer = ""
    @State private var selectedPlayers = 0

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil

    private let playerOptions = ["1","2","3","4","5+"]

    @ObservedObject var vm: CreateWorkoutViewModel


    var body: some View {
            VStack(spacing: 0) {
                // Header
                ZStack {
                    Rectangle()
                        .fill(Color.blueColor)
                        .frame(maxWidth: .infinity, minHeight: 103, maxHeight: 103)
                        .cornerRadius(20)
                    Text("Create a workout".uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                }

                // Content
                ScrollView {
                    VStack(spacing: 16) {
                        photosCard
                        detailsCard
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 450)
                }
            }
            .ignoresSafeArea(.all)
            .background(Color.backViewColor.ignoresSafeArea())
        }

        // MARK: - Cards

        private var photosCard: some View {
            PhotosPicker(selection: $vm.selectedItem, matching: .images, photoLibrary: .shared()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.durkBlueColor)
                        .shadow(color: Color.blackShadowColor, radius: 40, x: 0, y: 12)

                    if let image = vm.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(alignment: .bottomTrailing) {
                                Text("Tap to change photo")
                                    .font(.footnote)
                                    .padding(8)
                                    .background(.thinMaterial)
                                    .clipShape(Capsule())
                                    .padding(12)
                            }
                    } else {
                        VStack(spacing: 12) {
                            Image("addPhoto")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            Text("Photos of training")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.grayColor)
                        }
                    }
                }
                .frame(height: 280)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            }
            .buttonStyle(.plain)
            .onChange(of: vm.selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        vm.selectedImage = uiImage
                    }
                }
            }
        }

        private var detailsCard: some View {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.durkBlueColor.opacity(0.2))
                .shadow(color: Color.blackShadowColor, radius: 40, x: 0, y: 12)
                .overlay(
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Details")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)

                        sectionLabel("Name Training")
                        pillTextField(text: $vm.name, placeholder: "Name Training")

                        sectionLabel("Description of the workout")
                        pillTextField(text: $vm.descriptionText, placeholder: "Description of the workout")

                        sectionLabel("How many players can train")
                        playersSelector

                        sectionLabel("Approximate training time")
                        timeSecondsField(text: $vm.timer)
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
            TextField("", text: text, prompt: Text(placeholder).foregroundColor(Color.grayColor))
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
                ForEach(vm.playerOptions.indices, id: \.self) { i in
                    Button {
                        vm.selectedPlayersIndex = i
                    } label: {
                        Text(vm.playerOptions[i])
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(vm.selectedPlayersIndex == i ? .black : .whiteColor)
                            .frame(width: 66, height: 32)
                            .background(
                                Capsule().fill(vm.selectedPlayersIndex == i ?
                                               Color.yellow : Color.blueColor.opacity(0.35))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }

    private func timeSecondsField(text: Binding<String>) -> some View {
        // digits-only binding
        let digitsOnly = Binding<String>(
            get: { text.wrappedValue },
            set: { newValue in
                text.wrappedValue = newValue.filter { $0.isNumber }   // keep only 0-9
            }
        )

        return TextField("", text: digitsOnly, prompt: Text("Seconds (e.g., 180)").foregroundColor(Color.grayColor))
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

    #Preview {
        CreateWorkoutView(vm: CreateWorkoutViewModel())
    }
