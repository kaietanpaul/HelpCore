import Foundation
import Combine

final class CaseDetailViewModel: ObservableObject {
    @Published var charity: CharityCase

    private let store: CharityDataStore
    private var cancellables: Set<AnyCancellable> = []

    init(charity: CharityCase, store: CharityDataStore) {
        self.charity = charity
        self.store = store
        observe()
    }

    func watchAd() {
        store.markAdWatched(for: charity)
        refresh()
    }

    func refresh() {
        if let updated = store.allCases().first(where: { $0.id == charity.id }) {
            charity = updated
        }
    }

    private func observe() {
        store.$cases
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refresh()
            }
            .store(in: &cancellables)
    }
}
