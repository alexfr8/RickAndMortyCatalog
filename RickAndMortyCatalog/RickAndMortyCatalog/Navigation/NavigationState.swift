import Foundation
import Observation

@Observable
final class NavigationState: @unchecked Sendable {
    var path: [Screen] = []
    var presentingScreen: Screen?
    var presentingFullScreenCoverScreen: Screen?
    private var onDismissCallbacks: [String: Any] = [:]

    // MARK: - Push

    func push(to screens: [Screen], onDismiss: (() -> Void)? = nil) {
        path.append(contentsOf: screens)
    }

    func push(to screen: Screen, onDismiss: (() -> Void)? = nil) {
        path.append(screen)
    }

    // MARK: - Pop

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func popTo(screen: Screen) {
        guard let index = path.lastIndex(of: screen) else {
            path.removeLast()
            return
        }
        path.removeLast((path.count - 1) - index)
    }

    // MARK: - Present

    func present<T>(to screen: Screen, onDismiss: ((T) -> Void)? = nil) {
        presentingScreen = screen
        if let onDismiss = onDismiss {
            onDismissCallbacks[screen.id] = onDismiss
        }
    }

    func presentFullScreenCover<T>(to screen: Screen, onDismiss: ((T) -> Void)? = nil) {
        presentingFullScreenCoverScreen = screen
        if let onDismiss = onDismiss {
            onDismissCallbacks[screen.id] = onDismiss
        }
    }

    // MARK: - Dismiss

    func dismiss() {
        onDismissCallbacks.removeValue(forKey: presentingScreen?.id ?? "")
        presentingScreen = nil
    }

    func dismissFullScreenCover() {
        onDismissCallbacks.removeValue(forKey: presentingFullScreenCoverScreen?.id ?? "")
        presentingFullScreenCoverScreen = nil
    }

    func dismiss<T>(with value: T) {
        if let callback = onDismissCallbacks[presentingScreen?.id ?? ""] as? ((T) -> Void) {
            callback(value)
            onDismissCallbacks.removeValue(forKey: presentingScreen?.id ?? "")
        }
        presentingScreen = nil
    }

    func dismissFullScreenCover<T>(with value: T) {
        if let callback = onDismissCallbacks[presentingFullScreenCoverScreen?.id ?? ""] as? ((T) -> Void) {
            callback(value)
            onDismissCallbacks.removeValue(forKey: presentingFullScreenCoverScreen?.id ?? "")
        }
        presentingFullScreenCoverScreen = nil
    }
}
