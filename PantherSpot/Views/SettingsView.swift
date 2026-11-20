import SwiftUI

struct SettingsView: View {
    @AppStorage(AppAppearance.storageKey) private var appearance = AppAppearance.system
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @State private var showingWelcome = false
    @State private var showingSettingsError = false

    private var version: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "—"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "—"
        return "Version \(version) (\(build))"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 16) {
                        Image("LaunchMark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .accessibilityHidden(true)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Make space for focus.")
                                .font(.headline)
                            Text("PantherSpot at FIU")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section {
                    Picker("Appearance", selection: $appearance) {
                        ForEach(AppAppearance.allCases) { option in
                            Text(option.title).tag(option)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Label("Appearance", systemImage: "circle.lefthalf.filled")
                } footer: {
                    Text("System follows your device’s appearance. Your choice is saved for next time.")
                }

                Section("Getting Started") {
                    NavigationLink {
                        HowToUseView()
                    } label: {
                        Label("How to Use PantherSpot", systemImage: "book.closed")
                    }
                    Button {
                        showingWelcome = true
                    } label: {
                        Label("Replay Welcome", systemImage: "arrow.counterclockwise")
                    }
                }

                Section("Location & Study Spot Data") {
                    Text("Location access is optional. Tap My Location on the Map tab to find your position. You can browse spots and open directions without granting PantherSpot location access.")
                    Button {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            openURL(url) { accepted in
                                showingSettingsError = !accepted
                            }
                        }
                    } label: {
                        Label("Open Device Settings", systemImage: "gearshape")
                    }
                    Text("Noise levels, Wi-Fi, outlets, and seating are sample data for this student project. Check current conditions when you arrive.")
                    Text("Map pins show approximate building locations. Apple Maps provides directions and lets you choose a starting point.")
                }

                Section("About PantherSpot") {
                    Text("PantherSpot helps FIU students find places to study at Modesto A. Maidique Campus and Biscayne Bay Campus. Compare amenities, keep a shortlist, and share a spot with classmates.")
                    Text("Built by Alejandro, Pedro, Chris, and Sreeman for CodePath iOS development.")
                        .foregroundStyle(.secondary)
                    Text(version)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .sheet(isPresented: $showingWelcome) {
                WelcomeView(actionTitle: "Back to Settings") {
                    showingWelcome = false
                }
            }
            .alert("Couldn't open Settings", isPresented: $showingSettingsError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Open the Settings app on your device to manage PantherSpot’s permissions.")
            }
        }
    }
}

private struct HowToUseView: View {
    var body: some View {
        List {
            Section {
                Label("Find your next study spot", systemImage: "magnifyingglass")
                    .font(.headline)
                Text("Start in Explore. Search by spot name, building, or campus. Use Filters to choose a noise level, Wi-Fi, outlets, or group-study suitability, then tap Apply. Each card opens the spot’s details.")
            }
            Section {
                Label("Build your shortlist", systemImage: "heart")
                    .font(.headline)
                Text("Tap a heart to save a spot. Open the Favorites tab to see your shortlist, view details, or remove a saved spot. Your favorites stay saved on this device when you reopen the app.")
            }
            Section {
                Label("Find your way", systemImage: "map")
                    .font(.headline)
                Text("Select a pin on the Map tab, then tap View Details. Use the Study spots menu to focus on a building or show all spots.")
                Text("Get Walking Directions opens Apple Maps. If your location isn’t available, choose a starting point there.")
            }
            Section {
                Label("Meet up to study", systemImage: "square.and.arrow.up")
                    .font(.headline)
                Text("Open a spot’s details and tap Share Study Spot to send its Apple Maps link using the share sheet.")
            }
        }
        .navigationTitle("How to Use")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
