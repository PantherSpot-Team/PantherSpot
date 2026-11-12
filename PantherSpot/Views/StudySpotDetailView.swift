
import SwiftUI

struct StudySpotDetailView: View {
    let spot: StudySpot

    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        List {
            Section("Location") {
                Text(spot.location)
            }

            Section("About") {
                Text(spot.description)
            }

            Section("Amenities") {
                LabeledContent("Noise Level", value: spot.noiseLevel)
                LabeledContent("Wi-Fi", value: spot.hasWiFi ? "Available" : "Unavailable")
                LabeledContent("Outlets", value: spot.hasOutlets ? "Available" : "Unavailable")
                LabeledContent("Seating", value: spot.seatingInfo)
            }

            Section {
                Button {
                    favoritesManager.toggleFavorite(spot)
                } label: {
                    Label(
                        favoritesManager.isFavorite(spot)
                            ? "Remove from Favorites"
                            : "Add to Favorites",
                        systemImage: favoritesManager.isFavorite(spot)
                            ? "heart.fill" : "heart"
                    )
                }
            }
        }
        .navigationTitle(spot.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

