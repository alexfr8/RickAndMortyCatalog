import Foundation

actor MockRickAndMortyRepository: RickAndMortyRepositoryProtocol {
    let shouldSucceed: Bool

    private var _getCharactersNextPageCalled = false

    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }

    // MARK: - Repository Methods

    func getCharactersNextPage() async throws -> [DomainCharacter] {
        _getCharactersNextPageCalled = true
        if shouldSucceed {
            return DomainCharacter.mockList()
        } else {
            throw URLError(.badServerResponse)
        }
    }

    // MARK: - Inspectors

    func wasGetCharactersNextPageCalled() -> Bool { _getCharactersNextPageCalled }
}
