import SwiftUI
import Combine

@MainActor
final class FavoritesManager: ObservableObject {
    @Published private(set) var favoriteIDs: Set<UUID> = []

    func isFavorite(_ spot: StudySpot) -> Bool {
        favoriteIDs.contains(spot.id)
    }

    func toggleFavorite(_ spot: StudySpot) {
        if favoriteIDs.contains(spot.id) {
            favoriteIDs.remove(spot.id)
        } else {
            favoriteIDs.insert(spot.id)
        }
    }
}

