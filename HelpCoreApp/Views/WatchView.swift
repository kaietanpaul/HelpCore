import SwiftUI

struct WatchView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @EnvironmentObject private var store: CharityDataStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Watch to fund")
                        .font(.largeTitle.bold())
                        .padding(.horizontal)
                        .padding(.top)
                        .foregroundColor(.primary)

                    Text("Pick a case and your ad view unlocks sponsor dollars. No signup required.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)

                    ForEach(viewModel.recommended) { charity in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .top, spacing: 12) {
                                Circle()
                                    .fill(Color(hex: charity.heroColor))
                                    .frame(width: 46, height: 46)
                                    .overlay(
                                        Image(systemName: charity.imageName ?? "play.fill")
                                            .foregroundColor(.white)
                                    )
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(charity.title)
                                        .font(.headline)
                                    Text(charity.summary)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                }
                                Spacer()
                                Label("$15", systemImage: "gift.fill")
                                    .font(.caption.bold())
                                    .foregroundColor(.accentColor)
                            }

                            Button {
                                store.markAdWatched(for: charity)
                            } label: {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("Watch now")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("Funds this case")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(colors: [Color(hex: charity.heroColor), Color.accentColor], startPoint: .leading, endPoint: .trailing))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 90)
            }
            .navigationTitle("Watch")
        }
    }
}
