import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic

    private let spots = StudySpot.sampleSpots

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                ForEach(spots) { spot in
                    Marker(spot.name, coordinate: spot.coordinate)
                }
            }
            .navigationTitle("Map")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Study spots", systemImage: "mappin.and.ellipse") {
                        Button("Show all spots") {
                            cameraPosition = .automatic
                        }

                        ForEach(spots) { spot in
                            Button(spot.name) {
                                cameraPosition = .region(
                                    MKCoordinateRegion(
                                        center: spot.coordinate,
                                        latitudinalMeters: 600,
                                        longitudinalMeters: 600
                                    )
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MapView()
}
