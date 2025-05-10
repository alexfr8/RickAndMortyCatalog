import XCTest
@testable import RickAndMortyCatalog

final class NavigationStateTests: XCTestCase {
    var navigationState: NavigationState!

    override func setUp() {
        super.setUp()
        navigationState = NavigationState()
    }

    override func tearDown() {
        navigationState = nil
        super.tearDown()
    }

    func testPushSingleScreen() {
        let screen: Screen = .characters
        navigationState.push(to: screen)
        XCTAssertEqual(navigationState.path, [screen])
    }

    func testPushMultipleScreens() {
        let screens: [Screen] = [.splash, .characters, .search]
        navigationState.push(to: screens)
        XCTAssertEqual(navigationState.path, screens)
    }

    func testPopScreen() {
        navigationState.push(to: [.splash, .search])
        navigationState.pop()
        XCTAssertEqual(navigationState.path, [.splash])
    }

    func testPopToRoot() {
        navigationState.push(to: [.splash, .characters, .search])
        navigationState.popToRoot()
        XCTAssertTrue(navigationState.path.isEmpty)
    }

    func testPopToSpecificScreen() {
        navigationState.push(to: [.splash, .characters, .search])
        navigationState.popTo(screen: .characters)
        XCTAssertEqual(navigationState.path, [.splash, .characters])
    }

    func testPopToSpecificScreenNotFound() {
        navigationState.push(to: [.splash, .characters])
        navigationState.popTo(screen: .details(character: DomainCharacter.mock()))
        XCTAssertEqual(navigationState.path.count, 1)
    }

    func testPresentScreen() {
        let screen: Screen = .search
        navigationState.present(to: screen) {
            XCTAssertEqual(self.navigationState.presentingScreen, screen)
        }
    }

    func testDismissPresentedScreen() {
        navigationState.present(to: .splash) {
            self.navigationState.dismiss()
            XCTAssertNil(self.navigationState.presentingScreen)
        }
    }

    func testPresentFullScreenCover() {
        let screen: Screen = .search
        navigationState.presentFullScreenCover(to: screen) { [self] in
            XCTAssertEqual(navigationState.presentingFullScreenCoverScreen, screen)
        }
    }

    func testDismissFullScreenCover() {
        navigationState.presentFullScreenCover(to: .characters) { [self] in
            navigationState.dismissFullScreenCover()
            XCTAssertNil(navigationState.presentingFullScreenCoverScreen)
        }
    }

    func testDismissWithValueCallsCallback() {
        let screen: Screen = .search
        var wasCalled = false
        navigationState.present(to: screen) { (value: String) in
            wasCalled = value == "OK"
        }
        navigationState.dismiss(with: "OK")
        XCTAssertTrue(wasCalled)
    }

    func testDismissFullScreenWithValueCallsCallback() {
        let screen: Screen = .characters
        var wasCalled = false
        navigationState.presentFullScreenCover(to: screen) { (value: Int) in
            wasCalled = value == 99
        }
        navigationState.dismissFullScreenCover(with: 99)
        XCTAssertTrue(wasCalled)
    }
}
