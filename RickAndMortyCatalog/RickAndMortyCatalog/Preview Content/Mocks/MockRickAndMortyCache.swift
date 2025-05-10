import Foundation

actor MockRickAndMortyCache: RickAndMortyCacheProtocol {
        var characterPages: [Int: DomainCharacterPage] = [:]
        var currentPage = 1
        var lastPageIndex = 2

        func getCharacterPage(page: Int) async -> DomainCharacterPage? {
            characterPages[page]
        }

        func setCharacterPage(_ page: Int, value: DomainCharacterPage) async {
            characterPages[page] = value
        }

        func getCharacterPage() async -> Int {
            return currentPage
        }

        func incrementCharacterPage() async {
            currentPage += 1
        }

        func getLastCharacterPageIndex() async -> Int {
            return lastPageIndex
        }

        func getAllAvailableCharacters() async -> [DomainCharacter] {
            return characterPages.values.flatMap { $0.results }
        }

        func getCurrentPage() async -> Int {
            return currentPage
        }
    }
