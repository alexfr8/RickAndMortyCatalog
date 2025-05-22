import SwiftUI
import Networking

struct SearchScreenContainer: View {
    @Environment(\.app) private var app

    var body: some View {
        SearchScreen(repository: app.repository)
    }
}

private struct SearchScreen: View {
    @Environment(\.app) private var app

    @StateObject private var viewModel: SearchScreenViewModel
    @State private var searchText: String = ""
    @FocusState private var isFocused: Bool?

    init(repository: RickAndMortyRepositoryProtocol) {
        _viewModel = StateObject(
            wrappedValue: SearchScreenViewModel(
                searchCharactersUseCase: SearchCharactersUseCase(
                    repository: repository
                )
            )
        )
    }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("search_screen_title")
                            .foregroundColor(.text)

                        Spacer()
                        Button {
                            app.navigation.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                                .foregroundColor(.text)
                        }
                        .padding(.trailing)
                    }
                }
                HStack {
                    TextField("search_screen_placeholder", text: $searchText)
                        .padding()
                        .padding(.horizontal, 8)
                        .foregroundColor(.text)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
                        )
                        .focused($isFocused, equals: true)

                    Button {
                        searchText = ""
                        viewModel.clearSearch()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.text)
                    }
                    .padding(.trailing)
                }
                .padding(.top)
                if viewModel.characters.isEmpty && searchText.count > 2 {
                    Text("search_not_found_text'\(searchText)'")
                        .foregroundColor(.textError)
                        .background(Color.background)
                        .padding(8)

                } else if searchText.isEmpty {
                    Text("search_include_your_text_here")
                        .foregroundColor(.text)
                        .background(Color.background)
                        .padding(8)

                } else if searchText.count <= 2 {
                    Text("search_more_than_three_characters")
                        .foregroundColor(.text)
                        .background(Color.background)
                        .padding(8)
                }
                List {
                    ForEach(viewModel.characters) { character in
                        CharacterRow(character: character) { tappedCharacter in
                            app.navigation.dismiss(with: tappedCharacter)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .toolbar(.hidden, for: .navigationBar)
        }.onAppear {
            isFocused = true
        }
        .onChange(of: searchText, { _, newValue in
            Task {
                await viewModel.filterCharacters(searchText: newValue)
            }
        })
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
    SearchScreen(repository: MockRickAndMortyRepository())
}
