import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var userLocation = UserLocationManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var showingLocationError = false
    @State private var selectedSpotID: UUID?

    private let spots = StudySpot.sampleSpots

    private var selectedSpot: StudySpot? {
        spots.first { $0.id == selectedSpotID }
    }

    @ViewBuilder
    private func mapAmenities(for spot: StudySpot) -> some View {
        Label(spot.noiseLevel, systemImage: "speaker.wave.2")
        Label(spot.hasWiFi ? "Wi-Fi" : "No Wi-Fi", systemImage: spot.hasWiFi ? "wifi" : "wifi.slash")
        Label(spot.hasOutlets ? "Outlets" : "No outlets", systemImage: "powerplug")
    }

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, selection: $selectedSpotID) {
                if userLocation.isAuthorized {
                    UserAnnotation()
                }

                ForEach(spots) { spot in
                    Marker(spot.name, coordinate: spot.coordinate)
                        .tag(spot.id)
                        .tint(Color.accentColor)
                }
            }
            .navigationTitle("Map")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("My Location", systemImage: "location") {
                        selectedSpotID = nil
                        userLocation.findLocation()
                    }
                    .disabled(userLocation.isLocating)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Study spots", systemImage: "mappin.and.ellipse") {
                        Button("Show all spots") {
                            selectedSpotID = nil
                            withAnimation(reduceMotion ? nil : .smooth(duration: 0.4)) {
                                cameraPosition = .automatic
                            }
                        }

                        ForEach(spots) { spot in
                            Button(spot.name) {
                                selectedSpotID = spot.id
                                withAnimation(reduceMotion ? nil : .smooth(duration: 0.4)) {
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
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 8) {
                    if userLocation.isLocating {
                        ProgressView("Finding your location…")
                            .padding(12)
                            .background(.regularMaterial, in: Capsule())
                    }

                    if let spot = selectedSpot {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(spot.name)
                                        .font(.title3.bold())
                                    Text(spot.location)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Button("Close spot preview", systemImage: "xmark") {
                                    selectedSpotID = nil
                                }
                                .labelStyle(.iconOnly)
                                .frame(minWidth: 44, minHeight: 44)
                                .background(Color(.tertiarySystemFill), in: Circle())
                            }

                            ViewThatFits(in: .horizontal) {
                                HStack(spacing: 16) {
                                    mapAmenities(for: spot)
                                }
                                .fixedSize(horizontal: true, vertical: false)
                                VStack(alignment: .leading, spacing: 8) {
                                    mapAmenities(for: spot)
                                }
                            }
                            .labelStyle(.titleAndIcon)
                            .font(.caption.weight(.medium))
                            .foregroundStyle(.secondary)

                            NavigationLink {
                                StudySpotDetailView(spot: spot)
                            } label: {
                                Label("View Details", systemImage: "arrow.up.right")
                                    .foregroundStyle(colorScheme == .dark ? Color("BrandNavy") : .white)
                                    .frame(maxWidth: .infinity, minHeight: 28)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .padding(.bottom, 8)
                .animation(reduceMotion ? nil : .smooth(duration: 0.3), value: selectedSpotID)
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
