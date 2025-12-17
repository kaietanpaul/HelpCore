import Foundation

struct LeaderboardEntry: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var impactPoints: Int
    var casesHelped: Int
    var avatar: String
}
