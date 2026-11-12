import SwiftUI

struct StudySpotDetailView: View {
    let spot: StudySpot
    
    // Environment property to handle navigation back to Explore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Name & Location Header
                VStack(alignment: .leading, spacing: 6) {
                    Text(spot.name)
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.red)
                        Text(spot.location)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()

                // Amenities & Environment Details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Spot Details")
                        .font(.title2)
                        .bold()
                    
                    DetailRow(icon: "speaker.wave.2.fill", label: "Noise Level", value: spot.noiseLevel)
                    DetailRow(
                        icon: "wifi",
                        label: "Wi-Fi",
                        value: spot.hasWiFi ? "Available" : "No Wi-Fi"
                    )
                    DetailRow(
                        icon: "powerplug.fill",
                        label: "Outlets",
                        value: spot.hasOutlets ? "Available" : "No Outlets"
                    )
                    DetailRow(icon: "chair.lounge.fill", label: "Seating", value: spot.seatingInfo)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("About")
                        .font(.title2)
                        .bold()
                    
                    Text(spot.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Spot Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Explore")
                    }
                }
            }
        }
    }
}

// Helper view for info rows
struct DetailRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack {
            Label(label, systemImage: icon)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .bold()
        }
    }
}
