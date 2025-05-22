import XCTest
@testable import RickAndMortyCatalog

final class LoadInitialCharactersUseCaseTests: XCTestCase {

    func test_execute_callsGetCharactersNextPage() async throws {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        let useCase = LoadInitialCharactersUseCase(repository: mockRepo)

        // When
        _ = try await useCase.execute()

        // Then
        let result = await mockRepo.wasGetCharactersNextPageCalled()
        XCTAssertTrue(result)
    }

    func test_execute_throwsError_whenRepositoryFails() async {
        // Given
        let mockRepo = MockRickAndMortyRepository(shouldSucceed: false)
        let useCase = LoadInitialCharactersUseCase(repository: mockRepo)

        // Then
        await XCTAssertThrowsErrorAsync {
            try await useCase.execute()
        }
    }
}
