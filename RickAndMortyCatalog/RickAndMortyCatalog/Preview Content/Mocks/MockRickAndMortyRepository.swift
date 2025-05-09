import Foundation

actor MockRickAndMortyRepository: RickAndMortyRepositoryProtocol {
    let shouldSucceed: Bool

    private var _getCharactersNextPageCalled = false
    private var _getAllCharactersCalled = false

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

    func getAllCachedCharacters() async -> [DomainCharacter] {
        _getAllCharactersCalled = true
        if shouldSucceed {
            return DomainCharacter.mockList()
        } else {
            return []
        }
    }

    // MARK: - Inspectors

    func wasGetCharactersNextPageCalled() -> Bool { _getCharactersNextPageCalled }
    func wasGetAllCharactersCalled() -> Bool { _getAllCharactersCalled }
}
