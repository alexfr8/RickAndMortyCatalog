protocol GetAllCachedCharactersUseCaseProtocol: Sendable {
    func execute() async -> [DomainCharacter]
}

final class GetAllCachedCharactersUseCase: GetAllCachedCharactersUseCaseProtocol {
    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func execute() async -> [DomainCharacter] {
        await repository.getAllCachedCharacters()
    }
}

protocol GetCharactersNextPageUseCaseProtocol: Sendable {
    func execute() async throws -> [DomainCharacter]
}

final class GetCharactersNextPageUseCase: GetCharactersNextPageUseCaseProtocol {
    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func execute() async throws -> [DomainCharacter] {
        try await repository.getCharactersNextPage()
    }
}
