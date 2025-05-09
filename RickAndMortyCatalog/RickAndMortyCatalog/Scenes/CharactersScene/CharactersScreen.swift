import SwiftUI

struct CharactersScreenContainer: View {
    @Environment(\.app) private var app

    var body: some View {
        CharactersScreen(repository: app.repository)
    }
}

private struct CharactersScreen: View {
    @Environment(\.app) private var app
    @StateObject private var viewModel: CharactersScreenViewModel

    init(repository: RickAndMortyRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: CharactersScreenViewModel(repository: repository))
    }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                List {
                    ForEach(viewModel.characters) { character in
                        CharacterRow(character: character) { tappedCharacter in
                            app.navigation.push(to: .details)
                        }
                        .onAppear {
                            let halfIndex = viewModel.characters.count / 2
                            if character.id == viewModel.characters[halfIndex].id {
                                Task {
                                    await viewModel.loadCharacters()
                                }
                            }
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .text))
                            .scaleEffect(1.5)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("characters_title")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            app.navigation.push(to: .search)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.text)
                        }
                    }
                }
                .task {
                    await viewModel.onAppear()
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
    }
}

#Preview {
    CharactersScreen(repository: MockRickAndMortyRepository())
}
