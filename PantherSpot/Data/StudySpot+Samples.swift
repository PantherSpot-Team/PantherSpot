import Foundation
import CoreLocation

extension StudySpot {
    static let sampleSpots: [StudySpot] = [
        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "Green Library",
            campus: .mmc,
            location: "Modesto A. Maidique Campus, Green Library (GL)",
            coordinate: CLLocationCoordinate2D(latitude: 25.7570983, longitude: -80.3737528),
            description: "A library study space for reading and working on assignments.",
            informationTitle: "FIU Library Information",
            informationURL: URL(string: "https://library.fiu.edu/")!,
            noiseLevel: "Quiet",
            hasWiFi: true,
            hasOutlets: true,
            seatingInfo: "Individual desks and study tables",
            isGroupStudyFriendly: true
        ),

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "Graham Center",
            campus: .mmc,
            location: "Modesto A. Maidique Campus, Graham Center (GC)",
            coordinate: CLLocationCoordinate2D(latitude: 25.7562162, longitude: -80.3726972),
            description: "A campus gathering space for studying between classes.",
            informationTitle: "Graham Center Spaces",
            informationURL: URL(string: "https://dasa.fiu.edu/all-departments/graham-center/panther-spaces/")!,
            noiseLevel: "Lively",
            hasWiFi: true,
            hasOutlets: false,
            seatingInfo: "Shared tables and lounge seating",
            isGroupStudyFriendly: true
        ),

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            name: "Hubert Library",
            campus: .bbc,
            location: "Biscayne Bay Campus, Hubert Library (HL)",
            coordinate: CLLocationCoordinate2D(latitude: 25.9118026, longitude: -80.1399040),
            description: "A library study space for focused work on the Biscayne Bay Campus.",
            informationTitle: "FIU Library Information",
            informationURL: URL(string: "https://library.fiu.edu/")!,
            noiseLevel: "Quiet",
            hasWiFi: true,
            hasOutlets: true,
            seatingInfo: "Individual desks and group study tables",
            isGroupStudyFriendly: true
        ),

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            name: "Starbucks at MANGO",
            campus: .mmc,
            location: "Modesto A. Maidique Campus, MANGO",
            coordinate: CLLocationCoordinate2D(latitude: 25.757311, longitude: -80.376895),
            description: "A cafe setting in MANGO highlighted by FIU students as a study spot. Check current cafe access before visiting.",
            informationTitle: "FIU’s MANGO Study Guide (2024)",
            informationURL: URL(string: "https://news.fiu.edu/2024/and-were-back-a-students-guide-to-academic-success-and-campus-life-at-fiu")!,
            noiseLevel: "Lively",
            hasWiFi: true,
            hasOutlets: false,
            seatingInfo: "Cafe tables; seating availability varies",
            isGroupStudyFriendly: false
        ),

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            name: "Wolfe University Center",
            campus: .bbc,
            location: "Biscayne Bay Campus, Wolfe University Center (WUC)",
            coordinate: CLLocationCoordinate2D(latitude: 25.910425, longitude: -80.138915),
            description: "BBC’s student center is a casual option between classes when common-area seating is available. FIU lists device charging stations near the Panther Square stairway.",
            informationTitle: "Wolfe University Center Information",
            informationURL: URL(string: "https://dasa.fiu.edu/all-departments/wolfe-university-center/")!,
            noiseLevel: "Lively",
            hasWiFi: true,
            hasOutlets: true,
            seatingInfo: "Common-area seating; check availability",
            isGroupStudyFriendly: true
        ),

        StudySpot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
            name: "Academic One Tutoring Center",
            campus: .bbc,
            location: "Biscayne Bay Campus, Academic One (AC1), Room 160",
            coordinate: CLLocationCoordinate2D(latitude: 25.910145, longitude: -80.139688),
            description: "The Center for Academic Success offers in-person tutoring at AC1 160. Check FIU’s current tutoring schedule and arrange an appointment before visiting.",
            informationTitle: "FIU Tutoring & Appointment Information",
            informationURL: URL(string: "https://case.fiu.edu/mathstat/resources/math-help/")!,
            noiseLevel: "Quiet",
            hasWiFi: true,
            hasOutlets: false,
            seatingInfo: "Tutoring seating; check appointment availability",
            isGroupStudyFriendly: false
        )
    ]
}
