import Foundation
import SwiftUI

@MainActor
final class CharactersScreenViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var error: Error?
    @Published var characters: [DomainCharacter] = []

    private let getAllCachedCharactersUseCase: GetAllCachedCharactersUseCaseProtocol
    private let getCharactersNextPageUseCase: GetCharactersNextPageUseCaseProtocol

    init(
        getAllCachedCharactersUseCase: GetAllCachedCharactersUseCaseProtocol,
        getCharactersNextPageUseCase: GetCharactersNextPageUseCaseProtocol
    ) {
        self.getAllCachedCharactersUseCase = getAllCachedCharactersUseCase
        self.getCharactersNextPageUseCase = getCharactersNextPageUseCase
    }

    func onAppear() async {
        let useCase = await MainActor.run { self.getAllCachedCharactersUseCase }
        let characters = await useCase.execute()
        self.characters = characters
        self.isLoading = false
    }

    func loadCharacters() async {
        guard !isLoading else { return }

        isLoading = true
        do {
            let useCase = await MainActor.run { self.getCharactersNextPageUseCase }
            let response = try await useCase.execute()
            characters.append(contentsOf: response)
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
