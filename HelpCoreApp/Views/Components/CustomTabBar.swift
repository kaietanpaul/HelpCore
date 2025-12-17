import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: MainTab

    private let tabItems: [MainTab] = [.home, .search, .leaderboard, .profile]

    var body: some View {
        ZStack {
            HStack(spacing: 32) {
                ForEach(tabItems, id: \.self) { tab in
                    Button {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                            selectedTab = tab
                        }
                    } label: {
                        VStack(spacing: 6) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(selectedTab == tab ? Color.accentColor : Color.secondary)
                            Text(tab.title)
                                .font(.caption2)
                                .foregroundColor(selectedTab == tab ? Color.accentColor : Color.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)

            VStack {
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        selectedTab = .watch
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [Color.accentColor, Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 68, height: 68)
                            .shadow(color: Color.accentColor.opacity(0.4), radius: 12, x: 0, y: 8)
                        Image(systemName: MainTab.watch.icon)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .offset(y: -44)

                Spacer().frame(height: 0)
            }
        }
        .padding(.bottom, 12)
    }
}
