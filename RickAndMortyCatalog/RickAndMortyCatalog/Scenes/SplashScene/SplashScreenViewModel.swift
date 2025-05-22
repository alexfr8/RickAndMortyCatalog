import Foundation
import SwiftUI

@MainActor
final class SplashScreenViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var error: Error?
    @Published var shouldNavigate = false

    private let loadInitialCharactersUseCase: LoadInitialCharactersUseCaseProtocol

    init(loadInitialCharactersUseCase: LoadInitialCharactersUseCaseProtocol) {
        self.loadInitialCharactersUseCase = loadInitialCharactersUseCase
    }

    func onAppear() async {
        defer {
            isLoading = false
        }
        do {
            let useCase = await MainActor.run { self.loadInitialCharactersUseCase }
            try await useCase.execute()
            shouldNavigate = true
        } catch {
            self.error = error
        }
    }
}
