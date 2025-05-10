import XCTest
import Networking
@testable import RickAndMortyCatalog

final class RickAndMortyCacheTests: XCTestCase {
    var sut: RickAndMortyCache!

    override func setUp() {
        super.setUp()
        sut = RickAndMortyCache()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_setAndGetCharacterPage() async {
        // Given
        let page = DomainCharacterPage.mock1()

        // When
        await sut.setCharacterPage(1, value: page)
        let result = await sut.getCharacterPage(page: 1)

        // Then
        XCTAssertEqual(result?.results.first?.name.lowercased(), "Character 1".lowercased())
    }

    func test_incrementCharacterPage_updatesPageIndex() async {
        // When
        let initialPage = await sut.getCharacterPage()
        await sut.incrementCharacterPage()
        let updatedPage = await sut.getCharacterPage()

        // Then
        XCTAssertEqual(updatedPage, initialPage + 1)
    }

    func test_getAllAvailableCharacters_returnsAllCharacters() async {
        // Given
        let page1 = DomainCharacterPage.mock1()
        let page2 = DomainCharacterPage.mock2()

        // When
        await sut.setCharacterPage(1, value: page1)
        await sut.setCharacterPage(2, value: page2)

        let allCharacters = await sut.getAllAvailableCharacters()

        // Then
        XCTAssertEqual(allCharacters.count, 40)
        XCTAssertTrue(allCharacters.contains(where: { $0.name == "Character 1" }))
    }

    func test_getLastCharacterPageIndex_returnsMaxPage() async {
        // Given
        let page = DomainCharacterPage.mock1()
        // When
        await sut.setCharacterPage(1, value: page)

        let result = await sut.getLastCharacterPageIndex()

        // Then
        XCTAssertEqual(result, 3)
    }
}
