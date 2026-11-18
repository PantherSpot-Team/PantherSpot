
import SwiftUI

struct ExploreView: View {

    @EnvironmentObject var favoritesManager: FavoritesManager

    private let spots = StudySpot.sampleSpots

    @State private var showFilters = false

    @State private var selectedNoiseLevel: String = "All"
    @State private var wifiOnly = false
    @State private var outletsOnly = false

    private let noiseLevels = ["All", "Quiet", "Moderate", "Loud"]

    // Filter study spots based on selected criteria
    private var filteredSpots: [StudySpot] {
        spots.filter { spot in

            let matchesNoise =
                selectedNoiseLevel == "All" ||
                spot.noiseLevel == selectedNoiseLevel

            let matchesWiFi =
                !wifiOnly || spot.hasWiFi

            let matchesOutlets =
                !outletsOnly || spot.hasOutlets

            return matchesNoise &&
                   matchesWiFi &&
                   matchesOutlets
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredSpots) { spot in
                HStack {
                    NavigationLink {
                        StudySpotDetailView(spot: spot)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {

                            Text(spot.name)
                                .font(.headline)

                            Text(spot.location)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Noise Level: \(spot.noiseLevel)")

                                Text("Wi-Fi: \(spot.hasWiFi ? "Available" : "Unavailable")")

                                Text("Outlets: \(spot.hasOutlets ? "Available" : "Unavailable")")

                                Text("Seating: \(spot.seatingInfo)")
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()

                    Button {
                        favoritesManager.toggleFavorite(spot)
                    } label: {
                        Image(systemName:
                            favoritesManager.isFavorite(spot)
                            ? "heart.fill" : "heart"
                        )
                        .foregroundStyle(.red)
                        .font(.title2)
                    }
                    .buttonStyle(.borderless)
                    .accessibilityLabel(
                        favoritesManager.isFavorite(spot)
                        ? "Remove from favorites"
                        : "Add to favorites"
                    )
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("Explore")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFilters = true
                    } label: {
                        Label("Filters", systemImage: "line.3.horizontal.decrease")
                    }
                }
            }
            .sheet(isPresented: $showFilters) {
                NavigationStack {
                    Form {

                        Section("Noise Level") {
                            Picker("Noise Level", selection: $selectedNoiseLevel) {
                                ForEach(noiseLevels, id: \.self) { level in
                                    Text(level).tag(level)
                                }
                            }
                        }

                        Section("Amenities") {
                            Toggle("Wi-Fi Available", isOn: $wifiOnly)

                            Toggle("Power Outlets Available", isOn: $outletsOnly)
                        }

                        Section {
                            Button("Clear All Filters") {
                                selectedNoiseLevel = "All"
                                wifiOnly = false
                                outletsOnly = false
                            }
                            .foregroundStyle(.red)
                        }
                    }
                    .navigationTitle("Filter Study Spots")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Apply") {
                                showFilters = false
                            }
                        }

                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showFilters = false
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(FavoritesManager())
}
