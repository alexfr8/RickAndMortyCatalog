import XCTest
@testable import RickAndMortyCatalog

final class DetailsScreenViewModelTests: XCTestCase {
    var sut: DetailsScreenViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    @MainActor
    func test_getEpisodeInfo_success_setsEpisodes() async {
        // Given
        guard let character = DomainCharacter.mockList().first else {
            XCTFail("Bad character creation")
            return
        }
        let mockUseCase = MockGetEpisodesForCharacterUseCase()
        let viewModel = DetailsScreenViewModel(character: character, getEpisodesForCharacterUseCase: mockUseCase)

        // When
        await viewModel.getEpisodeInfo()

        // Then
        XCTAssertEqual(viewModel.episodes.count, DomainEpisodeDetail.mockList().count)
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(mockUseCase.wasCalled)
    }

    @MainActor
    func test_getEpisodeInfo_failure_setsError() async {
        // Given
        guard let character = DomainCharacter.mockList().first else {
            XCTFail("Bad character creation")
            return
        }
        let mockUseCase = MockGetEpisodesForCharacterUseCase()
        mockUseCase.shouldSucceed = false
        let viewModel = DetailsScreenViewModel(character: character, getEpisodesForCharacterUseCase: mockUseCase)

        // When
        await viewModel.getEpisodeInfo()

        // Then
        XCTAssertTrue(viewModel.episodes.isEmpty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(mockUseCase.wasCalled)
    }
}
