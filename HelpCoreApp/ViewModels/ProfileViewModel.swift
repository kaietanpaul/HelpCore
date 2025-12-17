import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published private(set) var profile: UserProfile

    private let store: CharityDataStore
    private var cancellables: Set<AnyCancellable> = []

    init(store: CharityDataStore) {
        self.store = store
        self.profile = store.profile
        observe()
    }

    private func observe() {
        store.$profile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                self?.profile = profile
            }
            .store(in: &cancellables)
    }
}
