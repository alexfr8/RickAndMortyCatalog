import Foundation
import SwiftUI
import Networking

protocol AppStateProtocol: Sendable {
    var repository: RickAndMortyRepositoryProtocol { get }
    var navigation: NavigationState { get }
}

final class AppState: AppStateProtocol {
    let repository: RickAndMortyRepositoryProtocol
    let navigation: NavigationState

    init(
        navigation: NavigationState,
        repository: RickAndMortyRepositoryProtocol
    ) {
        self.navigation = navigation
        self.repository = repository
    }
}
