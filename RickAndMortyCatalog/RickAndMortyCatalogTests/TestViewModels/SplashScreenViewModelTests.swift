import XCTest
@testable import RickAndMortyCatalog

final class SplashScreenViewModelTests: XCTestCase {
    var sut: SplashScreenViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    @MainActor
    func test_onAppear_successfulFetch_setsShouldNavigateTrue() async {
        // Given
        let mockRepository = MockRickAndMortyRepository()
        sut = SplashScreenViewModel(repository: mockRepository)

        // When
        await sut.onAppear()

        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.shouldNavigate)
        XCTAssertNil(sut.error)
        let wasCalled = await mockRepository.wasGetCharactersNextPageCalled()
        XCTAssertTrue(wasCalled)
    }

    @MainActor
    func test_onAppear_failedFetch_setsError() async {
        // Given
        let mockRepository = MockRickAndMortyRepository(shouldSucceed: false)
        sut = SplashScreenViewModel(repository: mockRepository)

        // When
        await sut.onAppear()

        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.shouldNavigate)
        XCTAssertNotNil(sut.error)
        let wasCalled = await mockRepository.wasGetCharactersNextPageCalled()
        XCTAssertTrue(wasCalled)
    }
}
