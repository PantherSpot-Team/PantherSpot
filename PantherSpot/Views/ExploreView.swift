import SwiftUI

struct ExploreView: View {
    @State private var showingSettings = false
    @State private var searchText = ""
    private let spots = StudySpot.sampleSpots

    private var searchQuery: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var matchingSpots: [StudySpot] {
        spots.filter { $0.matchesSearch(searchText) }
    }

    var body: some View {
        NavigationStack {
            List {
                if searchQuery.isEmpty {
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
                }

                Text(searchQuery.isEmpty ? "Around campus" : "\(matchingSpots.count) \(matchingSpots.count == 1 ? "spot" : "spots") found")
                    .font(.title2.bold())
                    .accessibilityAddTraits(.isHeader)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                if matchingSpots.isEmpty {
                    ContentUnavailableView {
                        Label("No study spots found", systemImage: "magnifyingglass")
                    } description: {
                        Text("Try a spot name, building, or campus.")
                    } actions: {
                        Button("Clear Search") { searchText = "" }
                            .buttonStyle(.bordered)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }

                ForEach(matchingSpots) { spot in
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
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search study spots")
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .scrollDismissesKeyboard(.interactively)
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
