import SwiftUI

struct CharactersScreenContainer: View {
    @Environment(\.app) private var app

    var body: some View {
        CharactersScreen()
    }
}

private struct CharactersScreen: View {
    @Environment(\.app) private var app
    @StateObject private var viewModel: CharactersScreenViewModel

    init() {
        _viewModel = StateObject(wrappedValue: CharactersScreenViewModel())
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Character")
        }
    }
}

#Preview {
    CharactersScreen()
}
