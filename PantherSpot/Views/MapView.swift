import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var userLocation = UserLocationManager()
    @State private var cameraPosition = Self.cameraFitting(StudySpot.sampleSpots)
    @State private var selectedCampus: Campus?
    @State private var showingLocationError = false
    @State private var selectedSpotID: UUID?

    private let spots = StudySpot.sampleSpots

    private var visibleSpots: [StudySpot] {
        spots.filter { selectedCampus == nil || $0.campus == selectedCampus }
    }

    private var selectedSpot: StudySpot? {
        visibleSpots.first { $0.id == selectedSpotID }
    }

    private static func cameraFitting(_ spots: [StudySpot]) -> MapCameraPosition {
        guard let first = spots.first else { return .automatic }
        var rect = MKMapRect(origin: MKMapPoint(first.coordinate), size: MKMapSize(width: 1, height: 1))
        for spot in spots.dropFirst() {
            rect = rect.union(MKMapRect(origin: MKMapPoint(spot.coordinate), size: MKMapSize(width: 1, height: 1)))
        }
        let padding = max(max(rect.width, rect.height) * 0.15,
                          150 * MKMapPointsPerMeterAtLatitude(first.coordinate.latitude))
        return .rect(rect.insetBy(dx: -padding, dy: -padding))
    }

    private func selectCampus(_ campus: Campus?) {
        userLocation.cancelRequest()
        selectedCampus = campus
        if !visibleSpots.contains(where: { $0.id == selectedSpotID }) {
            selectedSpotID = nil
        }
        withAnimation(reduceMotion ? nil : .smooth(duration: 0.4)) {
            cameraPosition = Self.cameraFitting(visibleSpots)
        }
    }

    private func showAllSpots() {
        selectedSpotID = nil
        selectCampus(nil)
    }

    private func focus(on spot: StudySpot) {
        selectCampus(spot.campus)
        selectedSpotID = spot.id
        withAnimation(reduceMotion ? nil : .smooth(duration: 0.4)) {
            cameraPosition = .region(MKCoordinateRegion(
                center: spot.coordinate,
                latitudinalMeters: 600,
                longitudinalMeters: 600
            ))
        }
    }

    private var campusPicker: some View {
        Picker("Campus", selection: Binding(get: { selectedCampus }, set: { selectCampus($0) })) {
            Text("All Campuses").tag(Campus?.none)
            ForEach(Campus.allCases) { campus in
                Text(campus.rawValue)
                    .accessibilityLabel(campus.name)
                    .tag(Optional(campus))
            }
        }
    }

    private var campusSummary: some View {
        ViewThatFits(in: .horizontal) {
            HStack {
                Text("\(visibleSpots.count) study spots")
                    .font(.subheadline.weight(.medium))
                Spacer(minLength: 16)
                Button("Show All Spots", action: showAllSpots)
                    .font(.subheadline)
            }
            .fixedSize(horizontal: true, vertical: false)
            VStack(alignment: .leading, spacing: 8) {
                Text("\(visibleSpots.count) study spots")
                    .font(.subheadline.weight(.medium))
                Button("Show All Spots", action: showAllSpots)
                    .font(.subheadline)
            }
        }
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

                ForEach(visibleSpots) { spot in
                    Marker(spot.name, coordinate: spot.coordinate)
                        .tag(spot.id)
                        .tint(Color.accentColor)
                }
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    if dynamicTypeSize.isAccessibilitySize {
                        campusPicker.pickerStyle(.menu)
                    } else {
                        campusPicker.pickerStyle(.segmented)
                    }
                    campusSummary
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)
            }
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
                        Button("Show all spots", action: showAllSpots)

                        ForEach(Campus.allCases) { campus in
                            Section(campus.name) {
                                ForEach(spots.filter { $0.campus == campus }) { spot in
                                    Button(spot.name) { focus(on: spot) }
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

                            Text("Amenities are sample information.")
                                .font(.caption)
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
