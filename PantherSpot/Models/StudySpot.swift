 
import Foundation
import CoreLocation

struct StudySpot: Identifiable {
    let id: UUID
    let name: String
    let campus: Campus
    let location: String
    let coordinate: CLLocationCoordinate2D
    let description: String
    let informationTitle: String
    let informationURL: URL
    let noiseLevel: String
    let hasWiFi: Bool
    let hasOutlets: Bool
    let seatingInfo: String
    let isGroupStudyFriendly: Bool

    init(
        id: UUID = UUID(),
        name: String,
        campus: Campus,
        location: String,
        coordinate: CLLocationCoordinate2D,
        description: String,
        informationTitle: String,
        informationURL: URL,
        noiseLevel: String,
        hasWiFi: Bool,
        hasOutlets: Bool,
        seatingInfo: String,
        isGroupStudyFriendly: Bool
    ) {
        self.id = id
        self.name = name
        self.campus = campus
        self.location = location
        self.coordinate = coordinate
        self.description = description
        self.informationTitle = informationTitle
        self.informationURL = informationURL
        self.noiseLevel = noiseLevel
        self.hasWiFi = hasWiFi
        self.hasOutlets = hasOutlets
        self.seatingInfo = seatingInfo
        self.isGroupStudyFriendly = isGroupStudyFriendly
    }
}

