import Foundation

struct CharityCase: Identifiable, Hashable {
    let id: UUID
    var title: String
    var category: String
    var summary: String
    var detail: String
    var location: String
    var goalAmount: Double
    var raisedAmount: Double
    var supporters: Int
    var watchCount: Int
    var heroColor: String
    var imageName: String?
    var tags: [String]

    var progress: Double {
        guard goalAmount > 0 else { return 0 }
        return min(raisedAmount / goalAmount, 1)
    }

    var progressLabel: String {
        let percent = Int(progress * 100)
        return "\(percent)% funded"
    }
}
