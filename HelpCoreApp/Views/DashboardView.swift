import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @EnvironmentObject private var store: CharityDataStore

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    TabView {
                        ForEach(viewModel.promoted) { charity in
                            NavigationLink {
                                CaseDetailView(viewModel: CaseDetailViewModel(charity: charity, store: store))
                            } label: {
                                CharityCaseCard(charity: charity)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .frame(height: 240)
                    .tabViewStyle(.page(indexDisplayMode: .always))

                    Text("Recommended for you")
                        .font(.headline)
                        .padding(.horizontal)

                    VStack(spacing: 16) {
                        ForEach(viewModel.recommended) { charity in
                            NavigationLink {
                                CaseDetailView(viewModel: CaseDetailViewModel(charity: charity, store: store))
                            } label: {
                                HStack(alignment: .center, spacing: 14) {
                                    Circle()
                                        .fill(Color(hex: charity.heroColor))
                                        .frame(width: 52, height: 52)
                                        .overlay(
                                            Image(systemName: charity.imageName ?? "heart.fill")
                                                .foregroundColor(.white)
                                                .font(.system(size: 22, weight: .bold))
                                        )

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(charity.title)
                                            .font(.subheadline.bold())
                                            .foregroundColor(.primary)
                                            .lineLimit(1)
                                        Text(charity.summary)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                        ProgressView(value: charity.progress)
                                    }

                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(.tertiaryLabel))
                                }
                                .padding()
                                .background(Color(.secondarySystemGroupedBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 90)
            }
            .navigationTitle("HelpCore")
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(store.profile.username)
                    .font(.title2.bold())
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Label("\(store.profile.impactPoints) impact", systemImage: "bolt.fill")
                    .font(.footnote.bold())
                    .foregroundColor(.accentColor)
                Text("\(store.profile.totalWatchCount) ads watched")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}
