import XCTest
@testable import RickAndMortyCatalog

final class GetEpisodesForCharacterUseCaseTests: XCTestCase {

    func test_execute_returnsEpisodesForCharacter() async throws {
        // Given
        let mockRepo = MockRickAndMortyRepository()

        let useCase = GetEpisodesForCharacterUseCase(repository: mockRepo)

        guard let character = DomainCharacter.mockList().first else {
            XCTFail("Error getting character")
            return
        }
        // When
        let result = try await useCase.execute(for: character)

        // Then
        XCTAssertEqual(result.first?.name, DomainEpisodeDetail.mockList().first?.name)
        XCTAssertEqual(result.last?.name, DomainEpisodeDetail.mockList().last?.name)
    }

    func test_execute_throwsErrorWhenRepositoryFails() async {
        // Given
        let mockRepo = MockRickAndMortyRepository(shouldSucceed: false)
        guard let character = DomainCharacter.mockList().first else {
            XCTFail("Error getting character")
            return
        }

        let useCase = GetEpisodesForCharacterUseCase(repository: mockRepo)

        // Then
        await XCTAssertThrowsErrorAsync {
            _ = try await useCase.execute(for: character)
        }
    }
}
