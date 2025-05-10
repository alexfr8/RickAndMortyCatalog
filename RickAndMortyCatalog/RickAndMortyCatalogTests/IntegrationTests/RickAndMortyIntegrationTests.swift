import XCTest
import Networking
@testable import RickAndMortyCatalog

final class RickAndMortyIntegrationTests: XCTestCase {
    var sut: RickAndMortyRepository!
    var service: RickAndMortyService!
    var cache: RickAndMortyCache!

    override func setUp() {
        super.setUp()
        service = RickAndMortyService()
        cache = RickAndMortyCache()
        sut = RickAndMortyRepository(service: service, cache: cache)
    }

    override func tearDown() {
        sut = nil
        service = nil
        cache = nil
        super.tearDown()
    }

    func test_integration_fetchCharactersAndCache() async throws {
        // Given
        let expectedPage = 1

        // When
        let characters = try await sut.getCharactersNextPage()

        // Then
        XCTAssertFalse(characters.isEmpty, "Should fetch characters from API")

        let cachedPage = await cache.getCharacterPage(page: expectedPage)
        XCTAssertNotNil(
            cachedPage,
            "Should cache the fetched page"
        )
        XCTAssertEqual(
            cachedPage?.results.count,
            characters.count,
            "Cached page should contain same number of characters"
        )
    }

    func test_integration_searchAndFetchEpisodes() async throws {
        // Given
        let searchQuery = "Rick"

        // When
        let characters = try await sut.searchCharacters(query: searchQuery)

        // Then
        XCTAssertFalse(characters.isEmpty, "Should find characters matching search query")

        if let firstCharacter = characters.first {
            let episodeIds = firstCharacter.episode.compactMap { url -> String? in
                guard let lastComponent = url.split(separator: "/").last else { return nil }
                return String(lastComponent)
            }

            let episodes = try await sut.searchBatchEpisodes(episodeList: episodeIds.joined(separator: ","))
            XCTAssertFalse(episodes.isEmpty, "Should fetch episodes for character")
        }
    }

    func test_integration_pagination() async throws {
        // Given
        let firstPage = 1
        let secondPage = 2

        // When
        let firstPageCharacters = try await sut.getCharactersNextPage()
        let secondPageCharacters = try await sut.getCharactersNextPage()

        // Then
        XCTAssertFalse(firstPageCharacters.isEmpty, "Should fetch first page")
        XCTAssertFalse(secondPageCharacters.isEmpty, "Should fetch second page")

        let cachedFirstPage = await cache.getCharacterPage(page: firstPage)
        let cachedSecondPage = await cache.getCharacterPage(page: secondPage)

        XCTAssertNotNil(cachedFirstPage, "Should cache first page")
        XCTAssertNotNil(cachedSecondPage, "Should cache second page")
        XCTAssertNotEqual(
            cachedFirstPage?.results.first?.id,
            cachedSecondPage?.results.first?.id,
            "Pages should contain different characters"
        )
    }
}
