import Foundation
import SwiftUI

@MainActor
final class SearchScreenViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var shouldNavigate = false
    @Published var characters: [DomainCharacter] = []

    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    func filterCharacters(searchText: String) async {
        defer {
            isLoading = false
        }
        if searchText.count > 2 {
            do {
                if !isLoading {
                    let candidates = await repository.getAllCachedCharacters()
                    characters = candidates.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                    if characters.isEmpty {
                        isLoading = true
                        characters = try await repository.searchCharacters(query: searchText)
                    }
                }
            } catch {
                self.error = error
            }
        } else {
            clearSearch()
        }
    }

    func clearSearch() {
        characters = []
    }
}
