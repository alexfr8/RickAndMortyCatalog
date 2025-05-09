import Foundation
import SwiftUI

@MainActor
final class SplashScreenViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var error: Error?
    @Published var shouldNavigate = false

    private let repository: RickAndMortyRepositoryProtocol

    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }

    func onAppear() async {
        defer {
            isLoading = false
        }
        do {
            _ = try await repository.getCharactersNextPage()
            shouldNavigate = true
        } catch {
            self.error = error
        }
    }
}
