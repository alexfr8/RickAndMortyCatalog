import Foundation

protocol LoadInitialCharactersUseCaseProtocol: Sendable {
    func execute() async throws
}

final class LoadInitialCharactersUseCase: LoadInitialCharactersUseCaseProtocol {
    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws {
        _ = try await repository.getCharactersNextPage()
    }
}
