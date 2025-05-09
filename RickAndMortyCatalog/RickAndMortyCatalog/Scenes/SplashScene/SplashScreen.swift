import SwiftUI
import Networking

struct SplashScreenContainer: View {
    @Environment(\.app) private var app

    var body: some View {
        SplashScreen()
    }
}

private struct SplashScreen: View {
    @Environment(\.app) private var app
    @StateObject private var viewModel: SplashScreenViewModel

    init() {
        _viewModel = StateObject(wrappedValue: SplashScreenViewModel())
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Splash")
        }
    }
}

#Preview {
    SplashScreen()
}
