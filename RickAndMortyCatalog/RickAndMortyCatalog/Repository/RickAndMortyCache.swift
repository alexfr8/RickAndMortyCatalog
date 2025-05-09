import Foundation

protocol RickAndMortyCacheProtocol: Sendable {
    func getCharacterPage(page: Int) async -> DomainCharacterPage?
    func setCharacterPage(_ page: Int, value: DomainCharacterPage) async
    func getCharacterPage() async -> Int
    func incrementCharacterPage() async
    func getLastCharacterPageIndex() async -> Int
    func getAllAvailableCharacters() async -> [DomainCharacter]
}

actor RickAndMortyCache: RickAndMortyCacheProtocol {
    private var charactersCache: [Int: DomainCharacterPage] = [:]

    private var currentCharacterPage: Int = 1

    func getCharacterPage(page: Int) async -> DomainCharacterPage? {
        charactersCache[page]
    }

    func setCharacterPage(_ page: Int, value: DomainCharacterPage) async {
        charactersCache[page] = value
    }

    func getCharacterPage() async -> Int {
        return currentCharacterPage
    }

    func incrementCharacterPage() async {
        currentCharacterPage += 1
    }

    func getLastCharacterPageIndex() async -> Int {
        guard let firstPage = charactersCache.first?.value else {
            return 0
        }
        return firstPage.pages
    }

    func getAllAvailableCharacters() async -> [DomainCharacter] {
        var charactersList: [DomainCharacter] = []
        for (_, value) in charactersCache {
            charactersList.append(contentsOf: value.results)
        }
        return charactersList
    }
}
