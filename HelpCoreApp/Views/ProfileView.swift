import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    header
                    stats
                    favorites
                }
                .padding(.horizontal)
                .padding(.bottom, 90)
            }
            .navigationTitle("Profile")
        }
    }

    private var header: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color.accentColor.opacity(0.2))
                .frame(width: 70, height: 70)
                .overlay(Image(systemName: "person.fill").foregroundColor(.accentColor).font(.system(size: 28, weight: .semibold)))
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.profile.username)
                    .font(.title2.bold())
                Text("Joined \(viewModel.profile.joinedLabel)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var stats: some View {
        VStack(spacing: 12) {
            ImpactStatView(title: "Ads watched", value: "\(viewModel.profile.totalWatchCount)", icon: "play.rectangle.fill")
            ImpactStatView(title: "Impact points", value: "\(viewModel.profile.impactPoints)", icon: "bolt.fill")
            ImpactStatView(title: "Streak", value: "\(viewModel.profile.streakDays) days", icon: "flame.fill")
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var favorites: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Favorite tags")
                .font(.headline)
            if viewModel.profile.favoriteTags.isEmpty {
                Text("Add a tag by watching more cases.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                FlowLayout(viewModel.profile.favoriteTags) { tag in
                    Text(tag)
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.accentColor.opacity(0.12))
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
