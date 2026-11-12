
import SwiftUI

struct ExploreView: View {

    @EnvironmentObject var favoritesManager: FavoritesManager

    private let spots = StudySpot.sampleSpots

    var body: some View {
        NavigationStack {
            List(spots) { spot in
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(spot.name)
                            .font(.headline)

                        Text(spot.location)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text("Noise Level: \(spot.noiseLevel)")
                            .font(.caption)
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
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(FavoritesManager())
}

