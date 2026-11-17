import SwiftUI
import MapKit

struct MapView: View {
    private let fiuRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.7565, longitude: -80.3770),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )

    var body: some View {
        NavigationStack {
            Map(initialPosition: .region(fiuRegion))
                .navigationTitle("Map")
        }
    }
}

#Preview {
    MapView()
}
