import SwiftUI

struct RootScreen: View {
    @Environment(\.app)
    private var app

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(.black).withAlphaComponent(0.8)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }

    var body: some View {
        @Bindable var navigation = app.navigation
        NavigationStack(path: $navigation.path) {
            SplashScreenContainer()
                .navigationDestination(for: Screen.self) { screen in
                    screen
                        .navigationBarBackButtonHidden()
                }
        }
        .sheet(item: $navigation.presentingScreen) { screen in
            screen
        }
        .fullScreenCover(item: $navigation.presentingFullScreenCoverScreen) { screen in
            screen
        }
    }
}
