import Foundation

actor MockRickAndMortyRepository: RickAndMortyRepositoryProtocol {
    let shouldSucceed: Bool

    private var _getCharactersNextPageCalled = false
    private var _getAllCharactersCalled = false
    private var _searchCharacterCalled = false

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

    func searchCharacters(query: String) async throws -> [DomainCharacter] {
        _searchCharacterCalled = true
        if shouldSucceed {
            return DomainCharacter.mockList()
        } else {
            throw URLError(.badServerResponse)
        }
    }

    // MARK: - Inspectors

    func wasGetCharactersNextPageCalled() -> Bool { _getCharactersNextPageCalled }
    func wasGetAllCharactersCalled() -> Bool { _getAllCharactersCalled }
    func wasSearchAllCharactersCalled() -> Bool { _searchCharacterCalled }
}
