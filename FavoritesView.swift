//
//  FavoritesView.swift
//  BetkingSwiftUI
//
//  Created by Gio's Mac on 30.08.25.
//

import SwiftUI

struct FavoritesView: View {
    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.blueColor)
                    .frame(width: .infinity, height: 145)
                    .cornerRadius(20)
                VStack {
                    Text("Favorites".uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.7))

                        TextField(
                            "",
                            text: $searchText,
                            prompt: Text("Search for a workout...")
                                .foregroundColor(Color.grayColor)
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
        }
        .ignoresSafeArea(.all)
        .background(Color.backViewColor.ignoresSafeArea())
    }
}

#Preview {
    FavoritesView()
}
