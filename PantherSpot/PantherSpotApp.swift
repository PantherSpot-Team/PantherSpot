//
//  PantherSpotApp.swift
//  PantherSpot
//
//  Created by alejandro perez on 11/10/26.
//

import SwiftUI

@main
struct PantherSpotApp: App {
    @AppStorage(AppAppearance.storageKey) private var appearance = AppAppearance.system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .background {
                    WindowAppearance(appearance: appearance)
                        .frame(width: 0, height: 0)
                        .accessibilityHidden(true)
                }
        }
    }
}
