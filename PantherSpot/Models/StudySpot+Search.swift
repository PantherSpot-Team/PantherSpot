import Foundation

extension StudySpot {
    func matchesSearch(_ query: String) -> Bool {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }
        return [name, location, campus.name, campus.rawValue].contains {
            $0.localizedStandardContains(query)
        }
    }
}
