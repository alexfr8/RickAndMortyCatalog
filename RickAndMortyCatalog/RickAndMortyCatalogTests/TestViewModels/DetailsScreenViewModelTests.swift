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
        let character = DomainCharacter.mock(
            id: 1,
            name: "Rick",
            episode: ["https://rickandmortyapi.com/api/episode/1",
                      "https://rickandmortyapi.com/api/episode/2"
                     ]
        )
        let mockRepo = MockRickAndMortyRepository()
        let viewModel = DetailsScreenViewModel(character: character, repository: mockRepo)

        // When
        await viewModel.getEpisodeInfo()

        // Then
        XCTAssertEqual(viewModel.episodes.count, DomainEpisodeDetail.mockList().count)
        XCTAssertNil(viewModel.error)
        let wasCalled = await mockRepo.wasSearchEpisodesCalled()
        XCTAssertTrue(wasCalled)
    }

    @MainActor
    func test_getEpisodeInfo_failure_setsError() async {
        // Given
        let character = DomainCharacter.mock(
            id: 1,
            name: "Rick",
            episode: ["https://rickandmortyapi.com/api/episode/1"]
        )
        let mockRepo = MockRickAndMortyRepository(shouldSucceed: false)
        let viewModel = DetailsScreenViewModel(character: character, repository: mockRepo)

        // When
        await viewModel.getEpisodeInfo()

        // Then
        XCTAssertTrue(viewModel.episodes.isEmpty)
        XCTAssertNotNil(viewModel.error)
        let wasCalled = await mockRepo.wasSearchEpisodesCalled()
        XCTAssertTrue(wasCalled)
    }
}
