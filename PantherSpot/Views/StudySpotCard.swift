import SwiftUI

struct StudySpotCard: View {
    let spot: StudySpot

    @EnvironmentObject private var favoritesManager: FavoritesManager
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var isFavorite: Bool { favoritesManager.isFavorite(spot) }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            NavigationLink {
                StudySpotDetailView(spot: spot)
            } label: {
                VStack(alignment: .leading, spacing: 16) {
                    Image(systemName: "building.2.crop.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.accentColor)
                        .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(spot.name)
                            .font(.title3.bold())
                            .foregroundStyle(.primary)
                        Text(spot.location)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Group {
                        if dynamicTypeSize.isAccessibilitySize {
                            VStack(alignment: .leading, spacing: 8) { amenities }
                        } else {
                            HStack(alignment: .top, spacing: 12) { amenities }
                        }
                    }
                    .labelStyle(.titleAndIcon)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                    Text(spot.seatingInfo)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button {
                withAnimation(reduceMotion ? nil : .snappy(duration: 0.25)) {
                    favoritesManager.toggleFavorite(spot)
                }
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                    .contentTransition(.symbolEffect(.replace))
                    .frame(width: 44, height: 44)
                    .background(Color.accentColor.opacity(0.08), in: Circle())
                    .contentShape(Circle())
            }
            .buttonStyle(.borderless)
            .accessibilityLabel("\(isFavorite ? "Remove" : "Save") \(spot.name) \(isFavorite ? "from" : "to") favorites")
        }
        .padding(20)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 22))
        .overlay(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color("BrandGold"))
                .frame(width: 36, height: 3)
                .padding(.leading, 20)
        }
    }

    @ViewBuilder
    private var amenities: some View {
        Label(spot.noiseLevel, systemImage: "speaker.wave.2")
        Label(spot.hasWiFi ? "Wi-Fi" : "No Wi-Fi", systemImage: spot.hasWiFi ? "wifi" : "wifi.slash")
        Label(spot.hasOutlets ? "Outlets" : "No outlets", systemImage: "powerplug")
    }
}
