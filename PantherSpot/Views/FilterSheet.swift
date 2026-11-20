import SwiftUI

struct FilterSheet: View {
    let noiseLevels: [String]
    let onApply: (StudySpotFilters) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var draft: StudySpotFilters

    init(filters: StudySpotFilters, noiseLevels: [String], onApply: @escaping (StudySpotFilters) -> Void) {
        self.noiseLevels = noiseLevels
        self.onApply = onApply
        _draft = State(initialValue: filters)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Noise level", selection: $draft.noiseLevel) {
                        Text("Any Noise Level").tag(String?.none)
                        ForEach(noiseLevels, id: \.self) { level in
                            Text(level).tag(Optional(level))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Label("Noise Level", systemImage: "speaker.wave.2")
                }

                Section {
                    Toggle(isOn: $draft.wifiOnly) {
                        Label("Wi-Fi Available", systemImage: "wifi")
                    }
                    Toggle(isOn: $draft.outletsOnly) {
                        Label("Outlets Available", systemImage: "powerplug")
                    }
                    Toggle(isOn: $draft.groupStudyOnly) {
                        Label("Group Study Friendly", systemImage: "person.2")
                    }
                } header: {
                    Text("Study Preferences")
                } footer: {
                    Text("Spots must match every selection. Amenities and group-study suitability are sample information.")
                }

                Section {
                    Button("Reset Filters") { draft = StudySpotFilters() }
                        .disabled(!draft.isActive)
                } footer: {
                    Text("Changes take effect when you tap Apply. Cancel keeps your current filters.")
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") { onApply(draft) }
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    FilterSheet(filters: StudySpotFilters(), noiseLevels: ["Quiet", "Lively"], onApply: { _ in })
}
