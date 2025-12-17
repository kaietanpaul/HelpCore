import Foundation
import Combine

final class DashboardViewModel: ObservableObject {
    @Published var promoted: [CharityCase] = []
    @Published var recommended: [CharityCase] = []

    private let store: CharityDataStore
    private var cancellables: Set<AnyCancellable> = []

    init(store: CharityDataStore) {
        self.store = store
        observe()
    }

    private func observe() {
        store.$cases
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cases in
                guard let self else { return }
                self.promoted = self.store.promotedCases
                self.recommended = cases.shuffled()
            }
            .store(in: &cancellables)
    }
}
