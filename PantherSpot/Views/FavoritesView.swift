
import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject var favoritesManager: FavoritesManager

    private let spots = StudySpot.sampleSpots

    private var favoriteSpots: [StudySpot] {
        spots.filter { favoritesManager.isFavorite($0) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if favoriteSpots.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart",
                        description: Text(
                            "Go to Explore and tap the heart to save a study spot."
                        )
                    )
                } else {
                    List(favoriteSpots) { spot in
                        NavigationLink {
                            StudySpotDetailView(spot: spot)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(spot.name)
                                    .font(.headline)

                                Text(spot.location)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text("Noise Level: \(spot.noiseLevel)")
                                    .font(.caption)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}

