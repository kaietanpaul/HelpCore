import SwiftUI

enum MainTab: Int, CaseIterable {
    case home
    case search
    case watch
    case leaderboard
    case profile

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .search: return "magnifyingglass"
        case .watch: return "play.circle.fill"
        case .leaderboard: return "trophy.fill"
        case .profile: return "person.crop.circle.fill"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .watch: return "Watch"
        case .leaderboard: return "Leaders"
        case .profile: return "Profile"
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var store: CharityDataStore
    @State private var selectedTab: MainTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    DashboardView(viewModel: DashboardViewModel(store: store))
                case .search:
                    SearchView(viewModel: SearchViewModel(store: store))
                case .watch:
                    WatchView(viewModel: DashboardViewModel(store: store))
                case .leaderboard:
                    LeaderboardView(viewModel: LeaderboardViewModel(store: store))
                case .profile:
                    ProfileView(viewModel: ProfileViewModel(store: store))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
            .ignoresSafeArea()

            CustomTabBar(selectedTab: $selectedTab)
                .padding(.horizontal)
                .padding(.bottom, 8)
        }
    }
}
