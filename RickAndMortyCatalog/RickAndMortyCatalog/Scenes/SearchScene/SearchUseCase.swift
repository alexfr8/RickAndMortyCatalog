import Foundation

protocol SearchCharactersUseCaseProtocol: Sendable {
    func execute(query: String) async throws -> [DomainCharacter]
}

final class SearchCharactersUseCase: SearchCharactersUseCaseProtocol {
    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [DomainCharacter] {
        let candidates = await repository.getAllCachedCharacters()
        let filtered = candidates.filter { $0.name.lowercased().contains(query.lowercased()) }
        if filtered.isEmpty {
            return try await repository.searchCharacters(query: query)
        } else {
            return filtered
        }
    }
}
