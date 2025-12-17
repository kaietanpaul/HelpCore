import SwiftUI

struct CharityCaseCard: View {
    let charity: CharityCase

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(charity.category.uppercased())
                        .font(.caption2.weight(.semibold))
                        .foregroundColor(.white.opacity(0.8))
                    Text(charity.title)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(charity.summary)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                }
                Spacer()
                if let imageName = charity.imageName {
                    Image(systemName: imageName)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }

            ProgressView(value: charity.progress)
                .tint(.white)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())

            HStack {
                Label("\(Int(charity.raisedAmount)) raised", systemImage: "chart.bar.fill")
                Spacer()
                Label("\(charity.supporters) supporters", systemImage: "person.2.fill")
            }
            .font(.caption.bold())
            .foregroundColor(.white.opacity(0.9))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: charity.heroColor))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color(hex: charity.heroColor).opacity(0.32), radius: 18, x: 0, y: 10)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
