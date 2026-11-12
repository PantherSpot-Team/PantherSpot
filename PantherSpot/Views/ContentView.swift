//
//  ContentView.swift
//  PantherSpot
//
//  Created by alejandro perez on 11/10/26.
//


import SwiftUI

struct ContentView: View {

    @StateObject private var favoritesManager = FavoritesManager()

    var body: some View {
        TabView {
            Tab("Explore", systemImage: "magnifyingglass") {
                ExploreView()
            }

            Tab("Map", systemImage: "map") {
                MapView()
            }

            Tab("Favorites", systemImage: "heart") {
                FavoritesView()
            }
        }
        .environmentObject(favoritesManager)
    }
}

#Preview {
    ContentView()
}
