import SwiftUI

struct CaseDetailView: View {
    @ObservedObject var viewModel: CaseDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                hero
                metrics
                description
                tags
            }
            .padding(.bottom, 120)
        }
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .bottom) {
            watchCTA
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [Color(hex: viewModel.charity.heroColor), Color(hex: viewModel.charity.heroColor).opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: 260)
                .overlay(alignment: .topTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.25))
                            .clipShape(Circle())
                            .padding()
                    }
                }

            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.charity.category.uppercased())
                    .font(.caption.bold())
                    .foregroundColor(.white.opacity(0.8))
                Text(viewModel.charity.title)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .lineLimit(2)
                Text(viewModel.charity.location)
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(24)
        }
    }

    private var metrics: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                metricCard(title: "Raised", value: "$\(Int(viewModel.charity.raisedAmount))", icon: "chart.bar.xaxis")
                metricCard(title: "Goal", value: "$\(Int(viewModel.charity.goalAmount))", icon: "target")
            }
            HStack(spacing: 12) {
                metricCard(title: "Supporters", value: "\(viewModel.charity.supporters)", icon: "person.3.fill")
                metricCard(title: "Ads watched", value: "\(viewModel.charity.watchCount)", icon: "play.rectangle.fill")
            }
            ProgressView(value: viewModel.charity.progress) {
                Text(viewModel.charity.progressLabel)
                    .font(.subheadline.bold())
            }
            .padding(.top, 8)
        }
        .padding(.horizontal)
    }

    private func metricCard(title: String, value: String, icon: String) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.accentColor)
                .frame(width: 32, height: 32)
                .background(Color.accentColor.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var description: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About")
                .font(.headline)
            Text(viewModel.charity.detail)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal)
    }

    private var tags: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Focus areas")
                .font(.headline)
            FlowLayout(viewModel.charity.tags) { tag in
                Text(tag)
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.accentColor.opacity(0.12))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal)
    }

    private var watchCTA: some View {
        VStack(spacing: 10) {
            Button(action: viewModel.watchAd) {
                HStack {
                    Image(systemName: "play.fill")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Watch an ad to help")
                            .font(.headline)
                        Text("Every view unlocks $15 of sponsor funding")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [Color(hex: viewModel.charity.heroColor), Color.accentColor], startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.horizontal)
            .padding(.bottom, 22)
        }
        .background(.ultraThinMaterial)
    }
}

struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let content: (Data.Element) -> Content

    init(_ data: Data, spacing: CGFloat = 8, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(Array(data), id: \.self) { item in
                    content(item)
                        .alignmentGuide(.leading) { dimension in
                            if width + dimension.width > geometry.size.width {
                                width = 0
                                height -= dimension.height + spacing
                            }
                            let result = width
                            width += dimension.width + spacing
                            return result
                        }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if item == data.last {
                                width = 0
                                height = 0
                            }
                            return result
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
