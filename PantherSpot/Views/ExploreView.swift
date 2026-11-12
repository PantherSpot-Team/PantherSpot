// xcode: set sdk=iOS

import SwiftUI

// Explore screen: tapping a row opens the detail screen for that study spot
struct ExploreView: View {
    private let spots = StudySpot.sampleSpots

    var body: some View {
        NavigationStack {
            List(spots) { spot in
                NavigationLink {
                    StudySpotDetailView(spot: spot)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(spot.name)
                            .font(.headline)
                        Text(spot.location)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(spot.noiseLevel)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Explore")
        }
    }
}

// Detail screen: receives the selected StudySpot and displays its info
struct StudySpotDetailView: View {
    let spot: StudySpot

    var body: some View {
        List {
            Section("Location") {
                Text(spot.location)
            }

            Section("Description") {
                Text(spot.description)
            }

            Section("Details") {
                LabeledContent("Noise Level", value: spot.noiseLevel)
                LabeledContent("Wi-Fi", value: spot.hasWiFi ? "Yes" : "No")
                LabeledContent("Outlets", value: spot.hasOutlets ? "Yes" : "No")
                LabeledContent("Seating", value: spot.seatingInfo)
            }
        }
        .navigationTitle(spot.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExploreView()
}
