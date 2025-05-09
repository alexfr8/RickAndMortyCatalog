import Foundation
import Networking
import SwiftUI

struct AppStateKey: EnvironmentKey {
    static let defaultValue: AppStateProtocol = AppState(
        navigation: NavigationState(),
        repository: RickAndMortyRepository(service: RickAndMortyService())
    )
}

extension EnvironmentValues {
    var app: AppStateProtocol {
        get { self[AppStateKey.self] }
        set { self[AppStateKey.self] = newValue }
    }
}
