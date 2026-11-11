import Foundation

struct StudySpot: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let description: String
    let noiseLevel: String
    let hasWiFi: Bool
    let hasOutlets: Bool
    let seatingInfo: String
}
