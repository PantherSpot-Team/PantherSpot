import Foundation

enum Campus: String, CaseIterable, Identifiable {
    case mmc = "MMC"
    case bbc = "BBC"

    var id: String { rawValue }

    var name: String {
        switch self {
        case .mmc: "Modesto A. Maidique Campus"
        case .bbc: "Biscayne Bay Campus"
        }
    }
}
