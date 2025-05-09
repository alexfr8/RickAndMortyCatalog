import Foundation
import SwiftUI

@MainActor
final class CharactersScreenViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var error: Error?
    @Published var characters: [DomainCharacter] = []

    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    func onAppear() async {
        characters = await repository.getAllCachedCharacters()
        isLoading = false
    }

    func loadCharacters() async {
        guard !isLoading else { return }

        isLoading = true
        do {
            let response = try await repository.getCharactersNextPage()
            characters.append(contentsOf: response)
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
