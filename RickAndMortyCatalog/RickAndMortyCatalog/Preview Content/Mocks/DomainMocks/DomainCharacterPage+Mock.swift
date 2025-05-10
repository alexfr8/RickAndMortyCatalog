import Foundation

extension DomainCharacterPage {
    static func mock1(
        count: Int = 20,
        pages: Int = 3,
        next: String? = "https://rickandmortyapi.com/api/character?page=2",
        prev: String? = nil,
        results: [DomainCharacter] = DomainCharacter.mockList(count: 20)
    ) -> DomainCharacterPage {
        return DomainCharacterPage(
            count: count,
            pages: pages,
            next: next,
            prev: prev,
            results: results
        )
    }

    static func mock2(
        count: Int = 20,
        pages: Int = 3,
        next: String? = "https://rickandmortyapi.com/api/character?page=3",
        prev: String? = "https://rickandmortyapi.com/api/character?page=1",
        results: [DomainCharacter] = DomainCharacter.mockList(count: 20)
    ) -> DomainCharacterPage {
        return DomainCharacterPage(
            count: count,
            pages: pages,
            next: next,
            prev: prev,
            results: results
        )
    }
}
