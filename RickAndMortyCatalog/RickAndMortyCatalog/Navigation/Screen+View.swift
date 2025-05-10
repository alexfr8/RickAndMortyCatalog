import Foundation
import SwiftUI

extension Screen: View {
    var body: some View {
        switch self {
        case .root:
            RootScreen()
        case .splash:
            SplashScreenContainer()
        case .characters:
            CharactersScreenContainer()
        case .details(let character):
            DetailssScreenContainer(character: character)
        case .search:
            SearchScreenContainer()
        }
    }
}
