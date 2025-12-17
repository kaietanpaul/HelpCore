import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @EnvironmentObject private var store: CharityDataStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search causes, tags, places", text: $viewModel.query)
                        .textInputAutocapitalization(.words)
                    if !viewModel.query.isEmpty {
                        Button("Clear") { viewModel.query = "" }
                            .font(.footnote)
                    }
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.horizontal)

                ScrollView {
                    LazyVStack(spacing: 14) {
                        ForEach(viewModel.results) { charity in
                            NavigationLink {
                                CaseDetailView(viewModel: CaseDetailViewModel(charity: charity, store: store))
                            } label: {
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(Color(hex: charity.heroColor).opacity(0.2))
                                        .frame(width: 52, height: 52)
                                        .overlay(
                                            Image(systemName: charity.imageName ?? "play.fill")
                                                .foregroundColor(Color(hex: charity.heroColor))
                                                .font(.system(size: 20, weight: .semibold))
                                        )
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(charity.title)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text(charity.summary)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                        HStack(spacing: 8) {
                                            Label(charity.location, systemImage: "mappin.and.ellipse")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            Label(charity.category, systemImage: "tag.fill")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
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
                    .padding(.vertical)
                    .padding(.bottom, 90)
                }
            }
            .navigationTitle("Discover")
        }
    }
}
