import SwiftUI

struct ExploreView: View {
    @State private var showingSettings = false
    @State private var searchText = ""
    @State private var showingFilters = false
    @State private var appliedFilters = StudySpotFilters()
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    private let spots = StudySpot.sampleSpots

    private var searchQuery: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var matchingSpots: [StudySpot] {
        spots.filter { $0.matchesSearch(searchText) && appliedFilters.matches($0) }
    }

    private var noiseLevels: [String] {
        Set(spots.map(\.noiseLevel)).sorted()
    }

    private var resultHeading: some View {
        Text(searchQuery.isEmpty && !appliedFilters.isActive
             ? "Around campus"
             : "\(matchingSpots.count) \(matchingSpots.count == 1 ? "spot" : "spots") found")
            .font(.title2.bold())
            .accessibilityAddTraits(.isHeader)
    }

    private var filterButton: some View {
        Button { showingFilters = true } label: {
            Label(appliedFilters.isActive ? "Filters (\(appliedFilters.activeCount))" : "Filters",
                  systemImage: appliedFilters.isActive ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease")
                .labelStyle(.titleAndIcon)
        }
        .buttonStyle(.bordered)
        .accessibilityLabel("Study spot filters")
        .accessibilityValue(appliedFilters.isActive ? "\(appliedFilters.activeCount) active" : "None active")
    }

    var body: some View {
        NavigationStack {
            List {
                if searchQuery.isEmpty && !appliedFilters.isActive {
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

                Group {
                    if dynamicTypeSize.isAccessibilitySize {
                        VStack(alignment: .leading, spacing: 12) {
                            resultHeading
                            filterButton
                        }
                    } else {
                        HStack {
                            resultHeading
                            Spacer(minLength: 8)
                            filterButton
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

                if appliedFilters.isActive {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(appliedFilters.summary)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Button("Clear Filters") { appliedFilters = StudySpotFilters() }
                            .font(.subheadline)
                            .buttonStyle(.borderless)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }

                if matchingSpots.isEmpty {
                    ContentUnavailableView {
                        Label("No study spots found", systemImage: "magnifyingglass")
                    } description: {
                        Text(appliedFilters.isActive
                             ? "Try fewer filters or a different search."
                             : "Try a spot name, building, or campus.")
                    } actions: {
                        if !searchQuery.isEmpty {
                            Button("Clear Search") { searchText = "" }
                                .buttonStyle(.bordered)
                        }
                        if appliedFilters.isActive {
                            Button("Clear Filters") { appliedFilters = StudySpotFilters() }
                                .buttonStyle(.bordered)
                        }
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
            .animation(reduceMotion ? nil : .snappy(duration: 0.25), value: appliedFilters)
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
            .sheet(isPresented: $showingFilters) {
                FilterSheet(filters: appliedFilters, noiseLevels: noiseLevels) { filters in
                    appliedFilters = filters
                    showingFilters = false
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
