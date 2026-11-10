import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            Text("Your favorite study spots will appear here.")
                .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
}
