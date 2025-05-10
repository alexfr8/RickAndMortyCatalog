import XCTest
@testable import RickAndMortyCatalog

final class CharactersScreenViewModelTests: XCTestCase {
    var sut: CharactersScreenViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    @MainActor
    func test_onAppear_loadsCachedCharacters() async {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        let viewModel = CharactersScreenViewModel(repository: mockRepo)

        // When
        await viewModel.onAppear()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, DomainCharacter.mockList().count)
        let wasCalled = await mockRepo.wasGetAllCharactersCalled()
        XCTAssertTrue(wasCalled)
    }

    @MainActor
    func test_loadCharacters_success_appendsCharacters() async {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        let viewModel = CharactersScreenViewModel(repository: mockRepo)
        viewModel.isLoading = false

        // When
        await viewModel.loadCharacters()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, DomainCharacter.mockList().count)
        XCTAssertNil(viewModel.error)
        let wasCalled = await mockRepo.wasGetCharactersNextPageCalled()
        XCTAssertTrue(wasCalled)
    }

    @MainActor
    func test_loadCharacters_failure_setsError() async {
        // Given
        let mockRepo = MockRickAndMortyRepository(shouldSucceed: false)
        let viewModel = CharactersScreenViewModel(repository: mockRepo)
        viewModel.isLoading = false

        // When
        await viewModel.loadCharacters()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
        let wasCalled = await mockRepo.wasGetCharactersNextPageCalled()
        XCTAssertTrue(wasCalled)
    }

    @MainActor
    func test_loadCharacters_doesNothingIfAlreadyLoading() async {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        let viewModel = CharactersScreenViewModel(repository: mockRepo)
        viewModel.isLoading = true

        // When
        await viewModel.loadCharacters()

        // Then
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, 0)
        let wasCalled = await mockRepo.wasGetCharactersNextPageCalled()
        XCTAssertFalse(wasCalled)
    }
}
