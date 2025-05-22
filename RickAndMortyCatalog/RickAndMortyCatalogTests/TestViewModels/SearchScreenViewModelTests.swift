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
        let mockUseCase = MockSearchCharactersUseCase()
        sut = SearchScreenViewModel(searchCharactersUseCase: mockUseCase)
        sut.characters = DomainCharacter.mockList()

        await sut.filterCharacters(searchText: "ab")

        XCTAssertTrue(sut.characters.isEmpty)
        XCTAssertFalse(mockUseCase.wasCalled)
    }

    @MainActor
    func test_filterCharacters_matchesCharacters_callsUseCase() async {
        let mockUseCase = MockSearchCharactersUseCase()
        mockUseCase.result = .success([DomainCharacter.mock(id: 1, name: "Character 1")])
        sut = SearchScreenViewModel(searchCharactersUseCase: mockUseCase)

        await sut.filterCharacters(searchText: "Character 1")

        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.characters.first?.name.lowercased(), "character 1")
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(mockUseCase.wasCalled)
    }

    @MainActor
    func test_filterCharacters_noCacheMatch_usesUseCase() async {
        let mockUseCase = MockSearchCharactersUseCase()
        mockUseCase.result = .success(DomainCharacter.mockList())
        sut = SearchScreenViewModel(searchCharactersUseCase: mockUseCase)

        await sut.filterCharacters(searchText: "summer")

        XCTAssertEqual(sut.characters.count, DomainCharacter.mockList().count)
        XCTAssertTrue(mockUseCase.wasCalled)
    }

    @MainActor
    func test_filterCharacters_remoteSearchFails_doesNotCrash() async {
        let mockUseCase = MockSearchCharactersUseCase()
        mockUseCase.result = .failure(NSError(domain: "Test", code: 1, userInfo: nil))
        sut = SearchScreenViewModel(searchCharactersUseCase: mockUseCase)

        await sut.filterCharacters(searchText: "morty")

        XCTAssertTrue(sut.characters.isEmpty)
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(mockUseCase.wasCalled)
    }
}
