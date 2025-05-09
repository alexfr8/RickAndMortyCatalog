import SwiftUI
import Networking

struct SplashScreenContainer: View {
    @Environment(\.app) private var app

    var body: some View {
        SplashScreen(repository: app.repository)
    }
}

private struct SplashScreen: View {
    @Environment(\.app) private var app
    @StateObject private var viewModel: SplashScreenViewModel

    init(repository: RickAndMortyRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: SplashScreenViewModel(repository: repository))
    }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            VStack {
                Image("splash_image")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .text))
                    .scaleEffect(1.5)
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .onChange(of: viewModel.shouldNavigate) { _, newValue in
            if newValue {
                app.navigation.push(to: .characters)
            }
        }
        .alert("alert_error_title", isPresented: .constant(viewModel.error != nil)) {
            Button("alert_error_ok") {
                viewModel.error = nil
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error")
        }
    }
}

#Preview {
    SplashScreen(repository: MockRickAndMortyRepository())
}
