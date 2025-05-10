import Foundation
import Network

public protocol RickAndMortyServiceProtocol: Sendable {
    func fetchCharacters(page: Int) async throws -> DataCharacterResponse
    func searchCharacter(name: String) async throws -> DataCharacterResponse
    func searchBatchEpisodes(query: String) async throws -> [DataEpisodeDetail]
}

public final class RickAndMortyService: RickAndMortyServiceProtocol {

    private let networkManager: NetworkManagerProtocol
    private let reachabilityManager: ReachabilityManagerProtocol

    public init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        self.reachabilityManager = ReachabilityManager()
    }

    deinit {
        let manager = reachabilityManager
        Task {
            await manager.close()
        }
    }

    private func checkConnectivity() async throws {
        let isConnected = await reachabilityManager.getStatus()
        if !isConnected {
            throw RickAndMortyServiceError.notReachable
        }
    }

    public func fetchCharacters(page: Int) async throws -> DataCharacterResponse {
        try await checkConnectivity()

        do {
            let route = RickAndMortyRoutes.fetchCharacters(page: page)
            let data = try await networkManager.performRequest(with: route)
            let parsedData: DataCharacterResponse = try JSONDecoder().decode(DataCharacterResponse.self, from: data)
            return parsedData
        } catch _ as DecodingError {
            throw RickAndMortyServiceError.decodingError
        } catch NetworkError.server {
            throw RickAndMortyServiceError.serverError
        } catch {
            print(error)
            throw RickAndMortyServiceError.unknown
        }
    }

    public func searchCharacter(name: String) async throws -> DataCharacterResponse {
        try await checkConnectivity()

        do {
            let route = RickAndMortyRoutes.searchCharacter(query: name)
            let data = try await networkManager.performRequest(with: route)
            let parsedData: DataCharacterResponse = try JSONDecoder().decode(DataCharacterResponse.self, from: data)
            return parsedData
        } catch _ as DecodingError {
            throw RickAndMortyServiceError.decodingError
        } catch NetworkError.server {
            throw RickAndMortyServiceError.serverError
        } catch {
            throw RickAndMortyServiceError.unknown
        }
    }

    public func searchBatchEpisodes(query: String) async throws -> [DataEpisodeDetail] {
        try await checkConnectivity()

        do {
            let route = RickAndMortyRoutes.searchBatchEpisodes(query: query)
            let data = try await networkManager.performRequest(with: route)
            if query.contains(",") {
                let parsedData: [DataEpisodeDetail] = try JSONDecoder().decode([DataEpisodeDetail].self, from: data)
                return parsedData
            } else {
                let parsedData: DataEpisodeDetail = try JSONDecoder().decode(DataEpisodeDetail.self, from: data)
                return [parsedData]
            }

        } catch _ as DecodingError {
            throw RickAndMortyServiceError.decodingError
        } catch NetworkError.server {
            throw RickAndMortyServiceError.serverError
        } catch {
            throw RickAndMortyServiceError.unknown
        }
    }
}

private enum RickAndMortyRoutes: NetworkRoute {
    case fetchCharacters(page: Int)
    case fetchCharacterDetail(characterId: Int)
    case searchCharacter(query: String)
    case searchBatchEpisodes(query: String)

    var baseUrl: String {
        "https://rickandmortyapi.com/api"
    }

    var path: String {
        switch self {

            case .fetchCharacters:
                "/api/character"
            case .fetchCharacterDetail(characterId: let characterId):
                "/api/character/\(characterId)/"
            case .searchCharacter:
                "/api/character"
            case .searchBatchEpisodes(query: let query):
                "/api/episode/\(query)"
        }
    }

    var queryItems: [String: Any] {
        switch self {
            case .fetchCharacters(page: let page):
                return ["page": page]
            case .searchCharacter(query: let query):
                return ["name": query]
            default:
                return [:]
        }
    }

    var body: Data? {
        nil
    }

    var type: NetworkRequestType {
        .get
    }

    var needsAuth: Bool {
        true
    }
}

public enum RickAndMortyServiceError: Error {
    case serverError
    case decodingError
    case notReachable
    case unknown
}
