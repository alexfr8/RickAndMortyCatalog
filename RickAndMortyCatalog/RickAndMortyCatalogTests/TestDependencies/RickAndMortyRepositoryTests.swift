import XCTest
import Networking
@testable import RickAndMortyCatalog

final class RickAndMortyRepositoryTests: XCTestCase {
    var sut: RickAndMortyRepository!
    var mockService: MockRickAndMortyService!
    var mockCache: MockRickAndMortyCache!

    override func setUp() {
        super.setUp()
        mockService = MockRickAndMortyService()
        mockCache = MockRickAndMortyCache()
        sut = RickAndMortyRepository(service: mockService, cache: mockCache)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        mockCache = nil
        super.tearDown()
    }

    func test_getCharactersNextPage_returnsCharactersAndIncrementsPage() async throws {
        // Given
        let expectedCharacters = [DomainCharacter.mock()]
        let mockResponse = DataCharacterResponse.mock(
            info: .mock(count: 1, pages: 1),
            results: DataCharacterDetail.mockList()
        )
        mockService.fetchCharactersResult = mockResponse

        // When
        let result = try await sut.getCharactersNextPage()

        // Then
        XCTAssertEqual(result.count, 5)
        let currentPage = await mockCache.getCurrentPage()
        XCTAssertEqual(currentPage, 2, "Should increment page")
        XCTAssertEqual(result.first?.name, expectedCharacters.first?.name, "Should return correct character name")

        let cachedPage = await mockCache.getCharacterPage(page: 1)
        XCTAssertNotNil(cachedPage, "Should cache the page")
        XCTAssertEqual(cachedPage?.results.count, 5, "Cached page should contain one character")
    }

    func test_getAllCachedCharacters_returnsCharactersFromCache() async {
        // Given
        let mockPage = DomainCharacterPage.mock1()
        await mockCache.setCharacterPage(1, value: mockPage)

        // When
        let result = await sut.getAllCachedCharacters()

        // Then
        XCTAssertEqual(result.count, mockPage.results.count, "Should return all characters from cache")
        XCTAssertEqual(result.first?.name, mockPage.results.first?.name, "Should return correct character name")
        XCTAssertEqual(result.last?.name, mockPage.results.last?.name, "Should return correct last character name")
    }

    func test_searchCharacters_returnsMatchingCharacters() async throws {
        // Given
        mockService.searchCharacterResult = DataCharacterResponse.mock()

        // When
        let result = try await sut.searchCharacters(query: "Rick Sanchez")

        // Then
        XCTAssertEqual(result.count, 5, "Should return one character")
        XCTAssertEqual(result.first?.name, "Character 1", "Should return correct character name")
    }

    func test_searchBatchEpisodes_returnsEpisodes() async throws {

        let expectedEpisode = DataEpisodeDetail.mock()
        mockService.searchBatchEpisodesResult = [expectedEpisode]

        let sut = RickAndMortyRepository(service: mockService, cache: MockRickAndMortyCache())

        // When
        let result = try await sut.searchBatchEpisodes(episodeList: "1")

        // Then
        XCTAssertEqual(result.count, 1, "Should return one episode")
        XCTAssertEqual(result.first?.name, "Pilot", "Should return correct episode name")
    }

    func test_getCharactersNextPage_whenServiceFails_throwsError() async {
        // Given
        mockService.fetchCharactersResult = nil // This will trigger the error

        // When/Then
        do {
            _ = try await sut.getCharactersNextPage()
            XCTFail("Should throw error")
        } catch {
            XCTAssertNotNil(error, "Should throw error")
        }
    }
}
