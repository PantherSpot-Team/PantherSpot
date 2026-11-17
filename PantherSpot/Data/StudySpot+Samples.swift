
import Foundation
import CoreLocation

extension StudySpot {

    static let sampleSpots: [StudySpot] = [

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "Green Library",
            location: "Modesto A. Maidique Campus, Green Library (GL)",
            coordinate: CLLocationCoordinate2D(latitude: 25.7570983, longitude: -80.3737528),
            description: "A library study space for reading and working on assignments.",
            noiseLevel: "Quiet",
            hasWiFi: true,
            hasOutlets: true,
            seatingInfo: "Individual desks and study tables"
        ),

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "Graham Center",
            location: "Modesto A. Maidique Campus, Graham Center (GC)",
            coordinate: CLLocationCoordinate2D(latitude: 25.7562162, longitude: -80.3726972),
            description: "A campus gathering space for studying between classes.",
            noiseLevel: "Lively",
            hasWiFi: true,
            hasOutlets: false,
            seatingInfo: "Shared tables and lounge seating"
        ),

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            name: "Hubert Library",
            location: "Biscayne Bay Campus, Hubert Library (HL)",
            coordinate: CLLocationCoordinate2D(latitude: 25.9118026, longitude: -80.1399040),
            description: "A library study space for focused work on the Biscayne Bay Campus.",
            noiseLevel: "Quiet",
            hasWiFi: true,
            hasOutlets: true,
            seatingInfo: "Individual desks and group study tables"
        )

    ]
}

