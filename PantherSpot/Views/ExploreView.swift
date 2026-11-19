import SwiftUI

struct ExploreView: View {
    @State private var showingSettings = false
    private let spots = StudySpot.sampleSpots

    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading, spacing: 16) {
                    Label("PANTHERSPOT", systemImage: "book.closed.fill")
                        .font(.caption.weight(.bold))
                        .tracking(1.5)
                        .foregroundStyle(Color("BrandGold"))
                    Text("Find your focus.")
                        .font(.largeTitle.bold())
                    Text("A quiet corner or a place between classes. Find your next study spot at FIU.")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(.white.opacity(0.85))
                    Label("\(spots.count) study spots to explore", systemImage: "mappin.and.ellipse")
                        .font(.caption.weight(.semibold))
                }
                .foregroundStyle(.white)
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("BrandNavy"), in: RoundedRectangle(cornerRadius: 24))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))

                Text("Around campus")
                    .font(.title2.bold())
                    .accessibilityAddTraits(.isHeader)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                ForEach(spots) { spot in
                    StudySpotCard(spot: spot)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 14, trailing: 16))
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Explore")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "gearshape") {
                        showingSettings = true
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(FavoritesManager())
}
