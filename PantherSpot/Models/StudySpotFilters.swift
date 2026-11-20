import Foundation

struct StudySpotFilters: Equatable {
    var noiseLevel: String?
    var wifiOnly = false
    var outletsOnly = false
    var groupStudyOnly = false

    var activeCount: Int {
        [noiseLevel != nil, wifiOnly, outletsOnly, groupStudyOnly].filter { $0 }.count
    }

    var isActive: Bool { activeCount > 0 }

    var summary: String {
        var selections: [String] = []
        if let noiseLevel { selections.append(noiseLevel) }
        if wifiOnly { selections.append("Wi-Fi") }
        if outletsOnly { selections.append("Outlets") }
        if groupStudyOnly { selections.append("Group study") }
        return selections.joined(separator: " · ")
    }

    func matches(_ spot: StudySpot) -> Bool {
        (noiseLevel == nil || spot.noiseLevel == noiseLevel)
            && (!wifiOnly || spot.hasWiFi)
            && (!outletsOnly || spot.hasOutlets)
            && (!groupStudyOnly || spot.isGroupStudyFriendly)
    }
}
