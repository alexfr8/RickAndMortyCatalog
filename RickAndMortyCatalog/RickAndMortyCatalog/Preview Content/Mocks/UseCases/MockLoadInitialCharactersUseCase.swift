import Foundation

@MainActor
final class MockLoadInitialCharactersUseCase: LoadInitialCharactersUseCaseProtocol {
    var shouldSucceed = true
    var wasCalled = false

    func execute() async throws {
        wasCalled = true
        if !shouldSucceed {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
    }
}
