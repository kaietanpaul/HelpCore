import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var results: [CharityCase] = []

    private let store: CharityDataStore
    private var cancellables: Set<AnyCancellable> = []

    init(store: CharityDataStore) {
        self.store = store
        observe()
    }

    private func observe() {
        Publishers.CombineLatest($query.removeDuplicates(), store.$cases)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] query, cases in
                guard let self else { return }
                let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.isEmpty {
                    self.results = cases
                } else {
                    self.results = cases.filter { caseItem in
                        caseItem.title.localizedCaseInsensitiveContains(trimmed) ||
                        caseItem.category.localizedCaseInsensitiveContains(trimmed) ||
                        caseItem.tags.contains { $0.localizedCaseInsensitiveContains(trimmed) }
                    }
                }
            }
            .store(in: &cancellables)
    }
}
