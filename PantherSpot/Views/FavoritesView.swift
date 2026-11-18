import SwiftUI

struct FavoritesView: View {
    let onBrowse: () -> Void

    @EnvironmentObject private var favoritesManager: FavoritesManager
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    private let spots = StudySpot.sampleSpots

    private var favoriteSpots: [StudySpot] {
        spots.filter { favoritesManager.isFavorite($0) }
    }

    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading, spacing: 12) {
                    Label("YOUR COLLECTION", systemImage: "heart.fill")
                        .font(.caption.weight(.bold))
                        .tracking(1.5)
                        .foregroundStyle(Color.accentColor)
                    Text("Your study shortlist.")
                        .font(.largeTitle.bold())
                    Text(favoriteSpots.isEmpty
                         ? "Keep your go-to places together."
                         : "\(favoriteSpots.count) saved \(favoriteSpots.count == 1 ? "spot" : "spots") for your next study session.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 12)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

                if favoriteSpots.isEmpty {
                    ContentUnavailableView {
                        Label("Make room for focus", systemImage: "heart.circle")
                    } description: {
                        Text("Tap the heart on a study spot to save it here. Your next favorite place is waiting in Explore.")
                    } actions: {
                        Button("Explore Study Spots", action: onBrowse)
                            .buttonStyle(.bordered)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                } else {
                    ForEach(favoriteSpots) { spot in
                        StudySpotCard(spot: spot)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 14, trailing: 16))
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .animation(reduceMotion ? nil : .snappy(duration: 0.25), value: favoritesManager.favoriteIDs)
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView(onBrowse: { })
        .environmentObject(FavoritesManager())
}
