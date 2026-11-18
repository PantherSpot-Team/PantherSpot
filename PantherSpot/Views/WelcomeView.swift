import SwiftUI

struct WelcomeView: View {
    var actionTitle = "Find a Study Spot"
    let onContinue: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                VStack(alignment: .leading, spacing: 16) {
                    Image("LaunchMark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .accessibilityHidden(true)

                    Text("Welcome to PantherSpot")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                    Text("Less time looking. More time studying.")
                        .font(.title3.weight(.medium))
                        .foregroundStyle(Color.accentColor)
                    Text("Find a place to focus between classes at FIU. Compare study spots, save your go-to places, and find your way there.")
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 24) {
                    feature("Find your fit", icon: "book.closed", detail: "Check noise level, Wi-Fi, outlets, and seating before you go.")
                    feature("Know where to go", icon: "map", detail: "Browse both campuses on the map and open walking directions in Apple Maps.")
                    feature("Keep your favorites", icon: "heart", detail: "Save spots for quick access and share a location with your study group.")
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 24))

                Text("Browse without an account. Location access is optional and only requested when you tap My Location.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: 600, alignment: .leading)
            .padding(24)
            .frame(maxWidth: .infinity)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom) {
            Button(action: onContinue) {
                Label(actionTitle, systemImage: "arrow.right")
                    .fontWeight(.semibold)
                    .foregroundStyle(colorScheme == .dark ? Color("BrandNavy") : .white)
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: 600)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
    }

    private func feature(_ title: String, icon: String, detail: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(Color.accentColor)
                .frame(width: 32)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    WelcomeView(onContinue: { })
}
