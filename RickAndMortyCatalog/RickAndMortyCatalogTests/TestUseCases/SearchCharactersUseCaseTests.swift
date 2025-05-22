import XCTest
@testable import RickAndMortyCatalog

final class SearchCharactersUseCaseTests: XCTestCase {

    func test_execute_returnsFilteredCachedCharacters_whenTheyExist() async throws {
        // Given
        let repository = MockRickAndMortyRepository()
        let useCase = SearchCharactersUseCase(repository: repository)

        // When
        let result = try await useCase.execute(query: "Character 1")

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Character 1")
    }

    func test_execute_callsRemoteSearch_whenNoCachedMatches() async throws {
        // Given
        let repository = MockRickAndMortyRepository()
        let useCase = SearchCharactersUseCase(repository: repository)

        // When
        let result = try await useCase.execute(query: "summer")

        // Then
        XCTAssertEqual(result.count, 5)
        XCTAssertEqual(result.first?.name, "Character 1")
    }

    func test_execute_throwsError_whenRemoteSearchFails() async {
        // Given
        enum TestError: Error { case failure }
        let repository = MockRickAndMortyRepository()

        let useCase = SearchCharactersUseCase(repository: repository)

        // Then
        await XCTAssertThrowsErrorAsync {
            _ = try await useCase.execute(query: "fail")
        }
    }
}
