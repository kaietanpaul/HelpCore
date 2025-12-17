import Foundation
import Combine

final class CharityDataStore: ObservableObject {
    @Published private(set) var cases: [CharityCase]
    @Published private(set) var profile: UserProfile
    @Published private(set) var leaderboard: [LeaderboardEntry]
    @Published var isAuthenticated: Bool = false

    private let watchReward: Double = 15

    init() {
        self.cases = MockData.cases
        self.profile = MockData.profile
        self.leaderboard = MockData.leaderboard
    }

    var promotedCases: [CharityCase] {
        cases.sorted { $0.watchCount > $1.watchCount }.prefix(5).map { $0 }
    }

    func allCases() -> [CharityCase] {
        cases
    }

    func updateAuthState(isLoggedIn: Bool) {
        isAuthenticated = isLoggedIn
    }

    func markAdWatched(for charity: CharityCase) {
        guard let index = cases.firstIndex(of: charity) else { return }
        cases[index].watchCount += 1
        cases[index].raisedAmount += watchReward
        profile.totalWatchCount += 1
        profile.impactPoints += Int(watchReward)

        if let leaderboardIndex = leaderboard.firstIndex(where: { $0.name == profile.username }) {
            leaderboard[leaderboardIndex].impactPoints = profile.impactPoints
            leaderboard[leaderboardIndex].casesHelped = profile.totalWatchCount
        } else {
            let entry = LeaderboardEntry(name: profile.username, impactPoints: profile.impactPoints, casesHelped: profile.totalWatchCount, avatar: "person.fill")
            leaderboard.append(entry)
        }
    }

    func refreshProfile(username: String? = nil) {
        if let username = username {
            profile.username = username
        }
    }
}

struct MockData {
    static let profile = UserProfile(
        username: "You",
        totalWatchCount: 12,
        impactPoints: 180,
        streakDays: 5,
        favoriteTags: ["Health", "Shelter", "Education"],
        joinedAt: Date(timeIntervalSince1970: 1_704_009_600)
    )

    static let cases: [CharityCase] = [
        CharityCase(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111") ?? UUID(),
            title: "Clean Water Wells",
            category: "Health",
            summary: "Bring fresh water to remote villages.",
            detail: "Each ad watch funds maintenance kits and training for locals to keep wells running all year.",
            location: "Nakuru, Kenya",
            goalAmount: 12000,
            raisedAmount: 8450,
            supporters: 623,
            watchCount: 2140,
            heroColor: "#2563EB",
            imageName: "drop.fill",
            tags: ["Water", "Health", "Sustainability"]
        ),
        CharityCase(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222") ?? UUID(),
            title: "School-in-a-Box",
            category: "Education",
            summary: "Equip mobile classrooms for displaced kids.",
            detail: "Help deliver solar-powered kits with tablets, books, and teacher stipends to keep learning alive.",
            location: "Gaziantep, Türkiye",
            goalAmount: 18000,
            raisedAmount: 11200,
            supporters: 482,
            watchCount: 1622,
            heroColor: "#7C3AED",
            imageName: "books.vertical.fill",
            tags: ["Education", "Children", "Refugees"]
        ),
        CharityCase(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333") ?? UUID(),
            title: "Rapid Shelter Kits",
            category: "Shelter",
            summary: "Weather-safe shelters after storms.",
            detail: "Pre-positioned shelters reach families within 24h. Ads fund stocking and rapid deployment.",
            location: "Cebu, Philippines",
            goalAmount: 15000,
            raisedAmount: 6900,
            supporters: 391,
            watchCount: 980,
            heroColor: "#EA580C",
            imageName: "house.fill",
            tags: ["Shelter", "Climate", "Emergency"]
        ),
        CharityCase(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444") ?? UUID(),
            title: "Rural Clinics on Wheels",
            category: "Health",
            summary: "Nurses travel weekly to remote areas.",
            detail: "Support fuel, meds, and connectivity so nurses can triage, vaccinate, and refer patients.",
            location: "Chiapas, Mexico",
            goalAmount: 21000,
            raisedAmount: 15420,
            supporters: 774,
            watchCount: 1288,
            heroColor: "#16A34A",
            imageName: "cross.case.fill",
            tags: ["Health", "Access", "Mothers"]
        ),
        CharityCase(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555") ?? UUID(),
            title: "Community Kitchens",
            category: "Hunger",
            summary: "Serve fresh meals daily.",
            detail: "Local teams source food from nearby farms. Every ad powers 4 plates of food for families.",
            location: "Detroit, USA",
            goalAmount: 10000,
            raisedAmount: 7400,
            supporters: 512,
            watchCount: 1432,
            heroColor: "#F59E0B",
            imageName: "fork.knife",
            tags: ["Food", "Families", "Local"]
        ),
        CharityCase(
            id: UUID(uuidString: "66666666-6666-6666-6666-666666666666") ?? UUID(),
            title: "Reforest Drylands",
            category: "Climate",
            summary: "Plant drought-proof trees.",
            detail: "Ads sponsor seedlings, drip irrigation, and training for farmer cooperatives.",
            location: "Kalimantan, Indonesia",
            goalAmount: 25000,
            raisedAmount: 11300,
            supporters: 610,
            watchCount: 760,
            heroColor: "#0EA5E9",
            imageName: "leaf.fill",
            tags: ["Climate", "Forests", "Livelihoods"]
        )
    ]

    static let leaderboard: [LeaderboardEntry] = [
        LeaderboardEntry(name: "Amira", impactPoints: 320, casesHelped: 18, avatar: "sun.max.fill"),
        LeaderboardEntry(name: "Jon", impactPoints: 280, casesHelped: 15, avatar: "flame.fill"),
        LeaderboardEntry(name: "Ravi", impactPoints: 260, casesHelped: 12, avatar: "bolt.fill"),
        LeaderboardEntry(name: "Linh", impactPoints: 240, casesHelped: 11, avatar: "heart.fill"),
        LeaderboardEntry(name: "You", impactPoints: 180, casesHelped: 12, avatar: "person.fill")
    ]
}
