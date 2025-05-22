import Foundation
import SwiftUI

@MainActor
final class DetailsScreenViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var shouldNavigate = false
    @Published var episodes: [DomainEpisodeDetail] = []

    private let getEpisodesForCharacterUseCase: GetEpisodesForCharacterUseCaseProtocol
    var character: DomainCharacter

    init(
        character: DomainCharacter,
        getEpisodesForCharacterUseCase: GetEpisodesForCharacterUseCaseProtocol
    ) {
        self.character = character
        self.getEpisodesForCharacterUseCase = getEpisodesForCharacterUseCase
    }

    func getEpisodeInfo() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let useCase = await MainActor.run { self.getEpisodesForCharacterUseCase }
            episodes = try await useCase.execute(for: character)
        } catch {
            self.error = error
        }
    }
}
