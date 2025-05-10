import Foundation
import SwiftUI

@MainActor
final class DetailsScreenViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var shouldNavigate = false
    @Published var episodes: [DomainEpisodeDetail] = []

    private let repository: RickAndMortyRepositoryProtocol
    var character: DomainCharacter

    init(character: DomainCharacter, repository: RickAndMortyRepositoryProtocol) {
        self.character = character
        self.repository = repository
    }

    func getEpisodeInfo() async {
        defer {
            isLoading = false
        }
        do {
            let episodesList: [String] = character.episode.map { episodeUrl in
                let url = URL(string: episodeUrl)
                return url?.lastPathComponent ?? ""
            }

            let query = episodesList.joined(separator: ",")
            isLoading = true
            episodes = try await repository.searchBatchEpisodes(episodeList: query)
        } catch {
            self.error = error
        }
    }
}
