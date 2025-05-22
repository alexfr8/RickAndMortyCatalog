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
        let mockAllUseCase = MockGetAllCachedCharactersUseCase()
        let mockNextPageUseCase = MockGetCharactersNextPageUseCase()
        let viewModel = CharactersScreenViewModel(
            getAllCachedCharactersUseCase: mockAllUseCase,
            getCharactersNextPageUseCase: mockNextPageUseCase
        )

        // When
        await viewModel.onAppear()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, DomainCharacter.mockList().count)
        XCTAssertTrue(mockAllUseCase.wasCalled)
    }

    @MainActor
    func test_loadCharacters_success_appendsCharacters() async {
        // Given
        let mockAllUseCase = MockGetAllCachedCharactersUseCase()
        let mockNextPageUseCase = MockGetCharactersNextPageUseCase()
        let viewModel = CharactersScreenViewModel(
            getAllCachedCharactersUseCase: mockAllUseCase,
            getCharactersNextPageUseCase: mockNextPageUseCase
        )
        viewModel.isLoading = false

        // When
        await viewModel.loadCharacters()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, DomainCharacter.mockList().count)
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(mockNextPageUseCase.wasCalled)
    }

    @MainActor
    func test_loadCharacters_failure_setsError() async {
        // Given
        let mockAllUseCase = MockGetAllCachedCharactersUseCase()
        let mockNextPageUseCase = MockGetCharactersNextPageUseCase()
        mockNextPageUseCase.shouldSucceed = false
        let viewModel = CharactersScreenViewModel(
            getAllCachedCharactersUseCase: mockAllUseCase,
            getCharactersNextPageUseCase: mockNextPageUseCase
        )
        viewModel.isLoading = false

        // When
        await viewModel.loadCharacters()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(mockNextPageUseCase.wasCalled)
    }

    @MainActor
    func test_loadCharacters_doesNothingIfAlreadyLoading() async {
        // Given
        let mockAllUseCase = MockGetAllCachedCharactersUseCase()
        let mockNextPageUseCase = MockGetCharactersNextPageUseCase()
        let viewModel = CharactersScreenViewModel(
            getAllCachedCharactersUseCase: mockAllUseCase,
            getCharactersNextPageUseCase: mockNextPageUseCase
        )
        viewModel.isLoading = true

        // When
        await viewModel.loadCharacters()

        // Then
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, 0)
        XCTAssertFalse(mockNextPageUseCase.wasCalled)
    }
}
