//
//  ContentView.swift
//  PantherSpot
//
//  Created by alejandro perez on 11/10/26.
//


import SwiftUI

struct ContentView: View {

    @StateObject private var favoritesManager = FavoritesManager()
    @State private var selectedTab = 0
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Group {
            if hasSeenWelcome {
                mainTabs
                    .transition(.opacity)
            } else {
                WelcomeView {
                    withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.25)) {
                        hasSeenWelcome = true
                    }
                }
                .transition(.opacity)
            }
        }
        .environmentObject(favoritesManager)
    }

    private var mainTabs: some View {
        TabView(selection: $selectedTab) {
            Tab("Explore", systemImage: "magnifyingglass", value: 0) {
                ExploreView()
            }

            Tab("Map", systemImage: "map", value: 1) {
                MapView()
            }

            Tab("Favorites", systemImage: "heart", value: 2) {
                FavoritesView { selectedTab = 0 }
            }
        }
    }
}

#Preview {
    ContentView()
}
