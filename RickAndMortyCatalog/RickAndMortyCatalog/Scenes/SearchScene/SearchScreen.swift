import SwiftUI
import Networking

struct SearchScreenContainer: View {
    @Environment(\.app) private var app

    var body: some View {
        SearchScreen()
    }
}

private struct SearchScreen: View {
    @Environment(\.app) private var app

    @StateObject private var viewModel: SearchScreenViewModel

    init() {
        _viewModel = StateObject(wrappedValue: SearchScreenViewModel())
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
    SearchScreen()
}
