import Foundation

@MainActor
final class MockGetAllCachedCharactersUseCase: GetAllCachedCharactersUseCaseProtocol {
    var wasCalled = false
    var result: [DomainCharacter] = DomainCharacter.mockList()

    func execute() async -> [DomainCharacter] {
        wasCalled = true
        return result
    }
}
