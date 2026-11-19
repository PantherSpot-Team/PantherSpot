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
    @State private var isOpening = true
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            appContent
                .allowsHitTesting(!isOpening)
                .accessibilityHidden(isOpening)

            if isOpening {
                LaunchIntroView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .environmentObject(favoritesManager)
        .task {
            guard isOpening else { return }
            do {
                try await Task.sleep(for: .milliseconds(700))
            } catch {
                return
            }
            withAnimation(.easeOut(duration: reduceMotion ? 0.15 : 0.25)) {
                isOpening = false
            }
        }
    }

    private var appContent: some View {
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
