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
        let mockUseCase = MockLoadInitialCharactersUseCase()
        sut = SplashScreenViewModel(loadInitialCharactersUseCase: mockUseCase)

        // When
        await sut.onAppear()

        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.shouldNavigate)
        XCTAssertNil(sut.error)
        XCTAssertTrue(mockUseCase.wasCalled)
    }

    @MainActor
    func test_onAppear_failedFetch_setsError() async {
        // Given
        let mockUseCase = MockLoadInitialCharactersUseCase()
        mockUseCase.shouldSucceed = false
        sut = SplashScreenViewModel(loadInitialCharactersUseCase: mockUseCase)

        // When
        await sut.onAppear()

        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.shouldNavigate)
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(mockUseCase.wasCalled)
    }
}
