import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var userLocation = UserLocationManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var showingLocationError = false

    private let spots = StudySpot.sampleSpots

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                if userLocation.isAuthorized {
                    UserAnnotation()
                }

                ForEach(spots) { spot in
                    Marker(spot.name, coordinate: spot.coordinate)
                }
            }
            .navigationTitle("Map")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("My Location", systemImage: "location") {
                        userLocation.findLocation()
                    }
                    .disabled(userLocation.isLocating)
                }

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
            .safeAreaInset(edge: .bottom) {
                if userLocation.isLocating {
                    ProgressView("Finding your location…")
                        .padding(12)
                        .background(.regularMaterial, in: Capsule())
                        .padding(.bottom, 8)
                }
            }
            .onChange(of: userLocation.location) { _, location in
                guard let location else { return }
                let visibleDistance = max(1200, location.horizontalAccuracy * 2.5)
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: location.coordinate,
                        latitudinalMeters: visibleDistance,
                        longitudinalMeters: visibleDistance
                    )
                )
            }
            .onChange(of: userLocation.error) { _, error in
                showingLocationError = error != nil
            }
            .onChange(of: scenePhase) { _, phase in
                if phase == .active {
                    userLocation.refreshAuthorization()
                }
            }
            .onDisappear {
                userLocation.cancelRequest()
            }
            .alert("Location unavailable", isPresented: $showingLocationError, presenting: userLocation.error) { error in
                if error.canOpenSettings {
                    Button("Settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            openURL(url)
                        }
                    }
                }
                Button("OK", role: .cancel) { }
            } message: { error in
                Text(error.message)
            }
        }
    }
}

#Preview {
    MapView()
}
