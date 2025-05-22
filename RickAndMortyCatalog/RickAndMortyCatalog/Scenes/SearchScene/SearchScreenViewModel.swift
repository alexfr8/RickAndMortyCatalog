import Foundation
import SwiftUI

@MainActor
final class SearchScreenViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var shouldNavigate = false
    @Published var characters: [DomainCharacter] = []

    private let searchCharactersUseCase: SearchCharactersUseCaseProtocol

    init(searchCharactersUseCase: SearchCharactersUseCaseProtocol) {
        self.searchCharactersUseCase = searchCharactersUseCase
    }

    func filterCharacters(searchText: String) async {
        defer {
            isLoading = false
        }
        if searchText.count > 2 {
            do {
                if !isLoading {
                    let useCase = await MainActor.run { self.searchCharactersUseCase }
                    characters = try await useCase.execute(query: searchText)
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
