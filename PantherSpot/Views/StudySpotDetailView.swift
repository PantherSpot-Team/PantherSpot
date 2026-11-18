import SwiftUI
import MapKit

struct StudySpotDetailView: View {
    let spot: StudySpot

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var showingMapsError = false

    private var mapItem: MKMapItem {
        let item = MKMapItem(
            location: CLLocation(latitude: spot.coordinate.latitude, longitude: spot.coordinate.longitude),
            address: nil
        )
        item.name = spot.name
        return item
    }

    private var shareURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.apple.com"
        components.queryItems = [
            URLQueryItem(name: "ll", value: "\(spot.coordinate.latitude),\(spot.coordinate.longitude)"),
            URLQueryItem(name: "q", value: spot.name)
        ]
        return components.url!
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "book.closed.fill")
                            .font(.title)
                            .accessibilityHidden(true)
                            .foregroundStyle(Color("BrandGold"))
                            .padding(14)
                            .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 18))
                        Spacer()
                        Text("FIU STUDY SPOT")
                            .font(.caption.weight(.bold))
                            .tracking(1.5)
                    }
                    Text(spot.name)
                        .font(.largeTitle.bold())
                    Label(spot.location, systemImage: "mappin.and.ellipse")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .foregroundStyle(.white)
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(colors: [Color("BrandNavy"), Color("BrandNavy").opacity(0.85)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing),
                    in: RoundedRectangle(cornerRadius: 24)
                )

                Button {
                    withAnimation(reduceMotion ? nil : .snappy(duration: 0.25)) {
                        favoritesManager.toggleFavorite(spot)
                    }
                } label: {
                    Label(
                        favoritesManager.isFavorite(spot) ? "Saved to Favorites" : "Save to Favorites",
                        systemImage: favoritesManager.isFavorite(spot) ? "heart.fill" : "heart"
                    )
                    .frame(maxWidth: .infinity, minHeight: 32)
                }
                .buttonStyle(.bordered)
                .accessibilityLabel(favoritesManager.isFavorite(spot) ? "Remove from Favorites" : "Add to Favorites")

                VStack(alignment: .leading, spacing: 16) {
                    Text("At a glance")
                        .font(.title2.bold())
                    DetailRow(icon: "speaker.wave.2.fill", label: "Noise level", value: spot.noiseLevel)
                    Divider()
                    DetailRow(icon: "wifi", label: "Wi-Fi", value: spot.hasWiFi ? "Available" : "Not available")
                    Divider()
                    DetailRow(icon: "powerplug.fill", label: "Outlets", value: spot.hasOutlets ? "Available" : "Not available")
                    Divider()
                    DetailRow(icon: "chair.lounge.fill", label: "Seating", value: spot.seatingInfo)
                }
                .padding(20)
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))

                VStack(alignment: .leading, spacing: 8) {
                    Text("About this spot")
                        .font(.title2.bold())
                    Text(spot.description)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 4)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Find your way")
                        .font(.title2.bold())
                    Map(
                        initialPosition: .region(MKCoordinateRegion(
                            center: spot.coordinate,
                            latitudinalMeters: 600,
                            longitudinalMeters: 600
                        )),
                        interactionModes: []
                    ) {
                        Marker(spot.name, coordinate: spot.coordinate)
                            .tint(Color.accentColor)
                    }
                    .frame(height: 190)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .accessibilityLabel("Map showing \(spot.name)")

                    Button {
                        showingMapsError = !mapItem.openInMaps(launchOptions: [
                            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
                        ])
                    } label: {
                        Label("Get Walking Directions", systemImage: "figure.walk")
                            .foregroundStyle(colorScheme == .dark ? Color("BrandNavy") : .white)
                            .frame(maxWidth: .infinity, minHeight: 32)
                    }
                    .buttonStyle(.borderedProminent)

                    Button {
                        showingMapsError = !mapItem.openInMaps()
                    } label: {
                        Label("Open in Apple Maps", systemImage: "map")
                            .frame(maxWidth: .infinity, minHeight: 32)
                    }
                    .buttonStyle(.bordered)

                    Text("Directions open in Apple Maps. You can choose a starting point there.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))

                ShareLink(item: shareURL, subject: Text(spot.name), message: Text("Let's study at \(spot.name)! \(spot.location)")) {
                    Label("Share Study Spot", systemImage: "square.and.arrow.up")
                        .frame(maxWidth: .infinity, minHeight: 32)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .padding(.bottom, 12)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Spot Details")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Couldn't open Apple Maps", isPresented: $showingMapsError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please try again. You can still view this spot's location in PantherSpot.")
        }
    }
}

struct DetailRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .firstTextBaseline, spacing: 16) {
                Label(label, systemImage: icon)
                    .foregroundStyle(.secondary)
                Spacer(minLength: 8)
                Text(value)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.trailing)
                    .fixedSize(horizontal: true, vertical: false)
            }
            VStack(alignment: .leading, spacing: 6) {
                Label(label, systemImage: icon)
                    .foregroundStyle(.secondary)
                Text(value)
                    .fontWeight(.semibold)
            }
        }
        .font(.subheadline)
        .accessibilityElement(children: .combine)
    }
}
