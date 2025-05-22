import Foundation

@MainActor
final class MockGetCharactersNextPageUseCase: GetCharactersNextPageUseCaseProtocol {
    var wasCalled = false
    var shouldSucceed = true
    var result: [DomainCharacter] = DomainCharacter.mockList()

    func execute() async throws -> [DomainCharacter] {
        wasCalled = true
        if shouldSucceed {
            return result
        } else {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
    }
}
