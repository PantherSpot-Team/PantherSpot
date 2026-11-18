import SwiftUI

struct ExploreView: View {
    @State private var showingAbout = false
    private let spots = StudySpot.sampleSpots
    @State private var showFilters = false
    @State private var selectedNoiseLevel = "All"
    @State private var wifiOnly = false
    @State private var outletsOnly = false
    @State private var draftNoiseLevel = "All"
    @State private var draftWiFiOnly = false
    @State private var draftOutletsOnly = false

    private var noiseLevels: [String] {
        ["All"] + Set(spots.map(\.noiseLevel)).sorted()
    }

    private var filtersActive: Bool {
        selectedNoiseLevel != "All" || wifiOnly || outletsOnly
    }

    private var filteredSpots: [StudySpot] {
        spots.filter { spot in
            (selectedNoiseLevel == "All" || spot.noiseLevel == selectedNoiseLevel)
                && (!wifiOnly || spot.hasWiFi)
                && (!outletsOnly || spot.hasOutlets)
        }
    }

    private func clearFilters() {
        selectedNoiseLevel = "All"
        wifiOnly = false
        outletsOnly = false
    }

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

                Text(filtersActive ? "\(filteredSpots.count) of \(spots.count) study spots" : "Around campus")
                    .font(.title2.bold())
                    .accessibilityAddTraits(.isHeader)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                if filteredSpots.isEmpty {
                    ContentUnavailableView {
                        Label("No matching study spots", systemImage: "line.3.horizontal.decrease.circle")
                    } description: {
                        Text("Try fewer filters to find a place to study.")
                    } actions: {
                        Button("Clear Filters", action: clearFilters)
                            .buttonStyle(.bordered)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }

                ForEach(filteredSpots) { spot in
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        draftNoiseLevel = selectedNoiseLevel
                        draftWiFiOnly = wifiOnly
                        draftOutletsOnly = outletsOnly
                        showFilters = true
                    } label: {
                        Label(filtersActive ? "Filters On" : "Filters", systemImage: "line.3.horizontal.decrease")
                    }
                    .accessibilityValue(filtersActive ? "Active" : "None")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("About PantherSpot", systemImage: "info.circle") {
                        showingAbout = true
                    }
                }
            }
            .sheet(isPresented: $showFilters) {
                NavigationStack {
                    Form {
                        Section("Noise Level") {
                            Picker("Noise Level", selection: $draftNoiseLevel) {
                                ForEach(noiseLevels, id: \.self) { level in
                                    Text(level).tag(level)
                                }
                            }
                        }
                        Section("Amenities") {
                            Toggle("Wi-Fi Available", isOn: $draftWiFiOnly)
                            Toggle("Power Outlets Available", isOn: $draftOutletsOnly)
                        }
                        Section {
                            Button("Reset Filters") {
                                draftNoiseLevel = "All"
                                draftWiFiOnly = false
                                draftOutletsOnly = false
                            }
                        }
                    }
                    .navigationTitle("Filter Study Spots")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Apply") {
                                selectedNoiseLevel = draftNoiseLevel
                                wifiOnly = draftWiFiOnly
                                outletsOnly = draftOutletsOnly
                                showFilters = false
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { showFilters = false }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAbout) {
                WelcomeView(actionTitle: "Back to Exploring") {
                    showingAbout = false
                }
            }
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(FavoritesManager())
}
