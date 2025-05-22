import Foundation

protocol GetEpisodesForCharacterUseCaseProtocol: Sendable {
    func execute(for character: DomainCharacter) async throws -> [DomainEpisodeDetail]
}

final class GetEpisodesForCharacterUseCase: GetEpisodesForCharacterUseCaseProtocol {
    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for character: DomainCharacter) async throws -> [DomainEpisodeDetail] {
        let episodeIds = character.episode.compactMap {
            URL(string: $0)?.lastPathComponent
        }
        let query = episodeIds.joined(separator: ",")
        return try await repository.searchBatchEpisodes(episodeList: query)
    }
}
