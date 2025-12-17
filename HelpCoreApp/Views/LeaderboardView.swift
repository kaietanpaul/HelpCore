import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var viewModel: LeaderboardViewModel

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Global")) {
                    ForEach(Array(viewModel.entries.enumerated()), id: \.element.id) { index, entry in
                        HStack(spacing: 12) {
                            Text("#\(index + 1)")
                                .font(.headline)
                                .frame(width: 32)
                                .foregroundColor(.secondary)
                            Circle()
                                .fill(Color.accentColor.opacity(0.2))
                                .frame(width: 42, height: 42)
                                .overlay(
                                    Image(systemName: entry.avatar)
                                        .foregroundColor(.accentColor)
                                )
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.name)
                                    .font(.headline)
                                Text("\(entry.casesHelped) cases • \(entry.impactPoints) impact")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.accentColor)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Leaderboard")
        }
    }
}
