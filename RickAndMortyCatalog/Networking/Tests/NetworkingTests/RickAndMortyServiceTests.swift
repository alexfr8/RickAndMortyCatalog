import XCTest
@testable import Networking

final class RickAndMortyServiceTests: XCTestCase {

    func testFetchCharactersSuccess() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager()
        let sut = RickAndMortyService(networkManager: mockNetworkManager)
        let expected = DataCharacterResponse.mock()
        mockNetworkManager.responseData = try JSONEncoder().encode(expected)

        //When
        let result = try await sut.fetchCharacters(page: 1)

        //Then
        XCTAssertEqual(result.results.count, expected.results.count)
    }

    func testSearchCharacterThrowsDecodingError() async {
        //Given
        let mockNetworkManager = MockNetworkManager()
        let sut = RickAndMortyService(networkManager: mockNetworkManager)
        mockNetworkManager.responseData = Data("invalid json".utf8)

        //When & Then
        do {
            _ = try await sut.searchCharacter(name: "Morty")
            XCTFail("Expected decoding error")
        } catch {
            XCTAssertEqual(error as? RickAndMortyServiceError, .decodingError)
        }
    }

    func testSearchBatchEpisodesWithSingleEpisode() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager()
        let sut = RickAndMortyService(networkManager: mockNetworkManager)
        let expected = DataEpisodeDetail.mock()
        mockNetworkManager.responseData = try JSONEncoder().encode(expected)

        //When
        let result = try await sut.searchBatchEpisodes(query: "1")

        //Then
        XCTAssertEqual(result.first?.name, "Pilot")
    }

    func testSearchBatchEpisodesWithMultipleEpisodes() async throws {
        //Given
        let mockNetworkManager = MockNetworkManager()
        let sut = RickAndMortyService(networkManager: mockNetworkManager)
        let expected = DataEpisodeDetail.mockList()
        mockNetworkManager.responseData = try JSONEncoder().encode([expected.first, expected.last])

        //When
        let result = try await sut.searchBatchEpisodes(query: "1,2")

        //Then
        XCTAssertEqual(result.count, 2)
    }
}


final class MockNetworkManager: NetworkManagerProtocol, @unchecked Sendable {
    var responseData: Data?
    var error: Error?

    func performRequest(with route: NetworkRoute) async throws -> Data {
        if let error = error {
            throw error
        }
        return responseData ?? Data()
    }
}
