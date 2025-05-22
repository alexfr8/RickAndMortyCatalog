import Foundation

@MainActor
final class MockGetEpisodesForCharacterUseCase: GetEpisodesForCharacterUseCaseProtocol {
    var shouldSucceed = true
    var wasCalled = false

    func execute(for character: DomainCharacter) async throws -> [DomainEpisodeDetail] {
        wasCalled = true
        if shouldSucceed {
            return DomainEpisodeDetail.mockList()
        } else {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
    }
}
