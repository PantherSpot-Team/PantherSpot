import SwiftUI

struct MapView: View {
    var body: some View {
        NavigationStack {
            Text("Find study spots on the map here.")
                .navigationTitle("Map")
        }
    }
}

#Preview {
    MapView()
}
