 
import Foundation

struct StudySpot: Identifiable {
    let id: UUID
    let name: String
    let location: String
    let description: String
    let noiseLevel: String
    let hasWiFi: Bool
    let hasOutlets: Bool
    let seatingInfo: String

    init(
        id: UUID = UUID(),
        name: String,
        location: String,
        description: String,
        noiseLevel: String,
        hasWiFi: Bool,
        hasOutlets: Bool,
        seatingInfo: String
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.description = description
        self.noiseLevel = noiseLevel
        self.hasWiFi = hasWiFi
        self.hasOutlets = hasOutlets
        self.seatingInfo = seatingInfo
    }
}

