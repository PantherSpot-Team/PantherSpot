import SwiftUI
import Combine

@MainActor
final class FavoritesManager: ObservableObject {
    private static let storageKey = "favoriteStudySpotIDs"
    private let defaults: UserDefaults

    @Published private(set) var favoriteIDs: Set<UUID> {
        didSet {
            defaults.set(favoriteIDs.map(\.uuidString).sorted(), forKey: Self.storageKey)
        }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        let savedIDs = defaults.stringArray(forKey: Self.storageKey) ?? []
        favoriteIDs = Set(savedIDs.compactMap { UUID(uuidString: $0) })
    }

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

