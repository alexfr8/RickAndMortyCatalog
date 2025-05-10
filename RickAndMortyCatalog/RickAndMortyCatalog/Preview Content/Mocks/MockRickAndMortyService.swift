import Foundation
import Networking

final class MockRickAndMortyService: RickAndMortyServiceProtocol, @unchecked Sendable {
        var fetchCharactersResult: DataCharacterResponse?
        var searchCharacterResult: DataCharacterResponse?
        var searchBatchEpisodesResult: [DataEpisodeDetail]?

        func fetchCharacters(page: Int) async throws -> DataCharacterResponse {
            guard let result = fetchCharactersResult else {
                throw RickAndMortyServiceError.serverError
            }
            return result
        }

        func searchCharacter(name: String) async throws -> DataCharacterResponse {
            guard let result = searchCharacterResult else {
                throw RickAndMortyServiceError.serverError
            }
            return result
        }

        func searchBatchEpisodes(query: String) async throws -> [DataEpisodeDetail] {
            guard let result = searchBatchEpisodesResult else {
                throw RickAndMortyServiceError.serverError
            }
            return result
        }
    }
