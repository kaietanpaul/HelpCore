import Foundation
import Combine

final class LeaderboardViewModel: ObservableObject {
    @Published private(set) var entries: [LeaderboardEntry] = []

    private let store: CharityDataStore
    private var cancellables: Set<AnyCancellable> = []

    init(store: CharityDataStore) {
        self.store = store
        observe()
    }

    private func observe() {
        store.$leaderboard
            .receive(on: DispatchQueue.main)
            .sink { [weak self] entries in
                self?.entries = entries.sorted { $0.impactPoints > $1.impactPoints }
            }
            .store(in: &cancellables)
    }
}
