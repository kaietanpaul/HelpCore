import Foundation

struct UserProfile {
    var username: String
    var totalWatchCount: Int
    var impactPoints: Int
    var streakDays: Int
    var favoriteTags: [String]
    var joinedAt: Date

    var joinedLabel: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: joinedAt)
    }
}
