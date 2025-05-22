import Foundation

@MainActor
final class MockSearchCharactersUseCase: SearchCharactersUseCaseProtocol {
    var wasCalled = false
    var result: Result<[DomainCharacter], Error> = .success([])

    func execute(query: String) async throws -> [DomainCharacter] {
        wasCalled = true
        switch result {
        case .success(let characters): return characters
        case .failure(let error): throw error
        }
    }
}
