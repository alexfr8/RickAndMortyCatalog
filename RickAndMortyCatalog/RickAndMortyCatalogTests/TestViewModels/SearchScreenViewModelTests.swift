import XCTest
@testable import RickAndMortyCatalog

final class SearchScreenViewModelTests: XCTestCase {
    var sut: SearchScreenViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    @MainActor
    func test_filterCharacters_searchTextTooShort_clearsSearch() async {
        // Given
        let mockRepo = MockRickAndMortyRepository(shouldSucceed: true)
        sut = SearchScreenViewModel(repository: mockRepo)
        sut.characters = DomainCharacter.mockList()

        // When
        await sut.filterCharacters(searchText: "ab")

        // Then
        XCTAssertTrue(sut.characters.isEmpty)
    }

    @MainActor
    func test_filterCharacters_matchesCachedCharacters_onlyUsesCache() async {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        sut = SearchScreenViewModel(repository: mockRepo)

        // When
        await sut.filterCharacters(searchText: "Character 1")

        // Then
        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.characters.first?.name.lowercased(), "Character 1".lowercased())
        XCTAssertFalse(sut.isLoading)
        let wasAllCharacterCalled = await mockRepo.wasGetAllCharactersCalled()
        XCTAssertTrue(wasAllCharacterCalled)
        let wasAllCharacterCalledWithoutSearchText = await mockRepo.wasSearchAllCharactersCalled()
        XCTAssertFalse(wasAllCharacterCalledWithoutSearchText)
    }

    @MainActor
    func test_filterCharacters_noCacheMatch_usesRemoteSearch() async {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        sut = SearchScreenViewModel(repository: mockRepo)

        // When
        await sut.filterCharacters(searchText: "summer")

        // Then
        XCTAssertEqual(sut.characters.count, DomainCharacter.mockList().count)
        let wasSearchAllCharactersCalled = await mockRepo.wasSearchAllCharactersCalled()
        XCTAssertTrue(wasSearchAllCharactersCalled)
    }

    @MainActor
    func test_filterCharacters_remoteSearchFails_doesNotCrash() async {
        // Given
        let mockRepo = MockRickAndMortyRepository(shouldSucceed: false)
        sut = SearchScreenViewModel(repository: mockRepo)

        // When
        await sut.filterCharacters(searchText: "morty")

        // Then
        XCTAssertTrue(sut.characters.isEmpty)
        let wasSearchAllCharactersCalled = await mockRepo.wasSearchAllCharactersCalled()
        XCTAssertTrue(wasSearchAllCharactersCalled)
    }
}
