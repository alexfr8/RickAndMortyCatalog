import XCTest
@testable import RickAndMortyCatalog

final class CharactersUseCaseTests: XCTestCase {
    func testGetAllCachedCharactersUseCaseReturnsCharacters() async {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        let useCase = GetAllCachedCharactersUseCase(repository: mockRepo)

        // When
        let result = await useCase.execute()

        // Then
        XCTAssertEqual(result.first?.name, "Character 1")
    }

    func testGetCharactersNextPageUseCaseReturnsCharacters() async throws {
        // Given
        let mockRepo = MockRickAndMortyRepository()
        let useCase = GetCharactersNextPageUseCase(repository: mockRepo)

        // When
        let result = try await useCase.execute()

        // Then
        XCTAssertEqual(result.first?.name, "Character 1")
    }

    func testGetCharactersNextPageUseCaseThrowsError() async {
        // Given
        enum TestError: Error { case test }
        let mockRepo = MockRickAndMortyRepository(shouldSucceed: false)

        let useCase = GetCharactersNextPageUseCase(repository: mockRepo)

        // Then

        await XCTAssertThrowsErrorAsync {
            _ = try await useCase.execute()
        }
    }
}
