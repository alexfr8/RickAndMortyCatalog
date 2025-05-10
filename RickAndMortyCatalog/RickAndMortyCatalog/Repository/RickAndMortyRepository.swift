import Foundation
import Networking

protocol RickAndMortyRepositoryProtocol: Sendable {
    func getCharactersNextPage() async throws -> [DomainCharacter]
    func getAllCachedCharacters() async -> [DomainCharacter]
    func searchCharacters(query: String) async throws -> [DomainCharacter]
    func searchBatchEpisodes(episodeList: String) async throws -> [DomainEpisodeDetail]
}

final class RickAndMortyRepository: RickAndMortyRepositoryProtocol {
    private let service: RickAndMortyServiceProtocol
    private let cache: RickAndMortyCacheProtocol

    init(service: RickAndMortyServiceProtocol, cache: RickAndMortyCacheProtocol = RickAndMortyCache()) {
        self.service = service
        self.cache = cache
    }

    func getCharactersNextPage() async throws -> [DomainCharacter] {
        if await morePagesAvailable() {
            do {
                let page = await cache.getCharacterPage()
                let charactersResponse = try await service.fetchCharacters(page: page)
                let characterDomain = charactersResponse.toDomain()
                await cache.setCharacterPage(page, value: characterDomain)
                await cache.incrementCharacterPage()
                return characterDomain.results
            } catch let error as RickAndMortyServiceError {
                throw mapServiceError(error)
            }
        } else {
            return []
        }
    }

    func getAllCachedCharacters() async -> [DomainCharacter] {
        return await cache.getAllAvailableCharacters()
    }

    func searchCharacters(query: String) async throws -> [DomainCharacter] {
        do {
            let searchResult = try await service.searchCharacter(name: query)
            let characterDomain = searchResult.toDomain()
            return characterDomain.results
        } catch let error as RickAndMortyServiceError {
            throw mapServiceError(error)
        }
    }

    func searchBatchEpisodes(episodeList: String) async throws -> [DomainEpisodeDetail] {
        do {
            let searchResult = try await service.searchBatchEpisodes(query: episodeList)
            let characterDomain = searchResult.toDomain()
            return characterDomain
        } catch let error as RickAndMortyServiceError {
            throw mapServiceError(error)
        }
    }

    // MARK: - Private Methods

    private func morePagesAvailable()  async -> Bool {
        let index = await cache.getLastCharacterPageIndex()
        guard let page = await cache.getCharacterPage(page: index) else {
            return true
        }
        return index < page.pages
    }

    private func mapServiceError(_ error: RickAndMortyServiceError) -> RepositoryError {
        switch error {
        case .unknown:
            return .unknown
        case .notReachable:
            return .reachabiltyError
        default:
            return .serverError
        }
    }
}

enum RepositoryError: Error {
    case serverError
    case reachabiltyError
    case unknown
}

extension RepositoryError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError:
            return String(localized: "error_description_server")
        case .unknown:
            return String(localized: "error_description_unknown")
        case .reachabiltyError:
            return String(localized: "error_description_reach")
        }
    }

    var failureReason: String? {
        switch self {
        case .serverError:
            return String(localized: "error_reason_server")
        case .unknown:
            return String(localized: "error_reason_unknown")
        case .reachabiltyError:
            return String(localized: "error_reason_reach")
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .serverError:
            return String(localized: "error_suggestion_server")
        case .unknown:
            return String(localized: "error_suggestion_unknown")
        case .reachabiltyError:
            return String(localized: "error_suggestion_reach")
        }
    }
}
