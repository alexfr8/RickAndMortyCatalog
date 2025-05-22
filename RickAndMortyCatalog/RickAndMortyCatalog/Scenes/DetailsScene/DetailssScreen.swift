import SwiftUI

struct DetailssScreenContainer: View {
    @Environment(\.app) private var app
    private var character: DomainCharacter

    init(character: DomainCharacter) {
        self.character = character
    }
    var body: some View {
        DetailsScreen(character: character, repository: app.repository)
    }
}

struct DetailsScreen: View {
    @Environment(\.app) private var app
    @StateObject private var viewModel: DetailsScreenViewModel

    init(character: DomainCharacter, repository: RickAndMortyRepositoryProtocol) {
        _viewModel = StateObject(
            wrappedValue: DetailsScreenViewModel(
                character: character,
                getEpisodesForCharacterUseCase: GetEpisodesForCharacterUseCase(
                    repository: repository
                )
            )
        )
    }

    var body: some View {
            ZStack {
                Color.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        HStack {
                            AsyncImageView(urlString: viewModel.character.image)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))

                            Spacer()

                            InfoSectionView(
                                title: String(localized: "details_status_title"),
                                value: viewModel.character.status
                            )
                            .padding()
                        }

                        Text(viewModel.character.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.text)
                        HStack {
                            InfoSectionView(
                                title: String(localized: "details_gender_title"),
                                value: viewModel.character.gender
                            )
                            .padding(8)
                            Spacer()
                            InfoSectionView(
                                title: String(localized: "details_species_title"),
                                value: viewModel.character.species
                            )
                            .padding(8)
                        }
                        .padding(4)

                        HStack {
                            InfoSectionView(
                                title: String(localized: "details_origin_title"),
                                value: viewModel.character.origin.name
                            )
                            .padding(8)
                            Spacer()
                            InfoSectionView(
                                title: String(localized: "details_location_title"),
                                value: viewModel.character.location.name
                            )
                            .padding(8)
                        }
                        .padding(4)

                        HStack {
                            Text("details_episodes")
                                .font(.headline)
                                .foregroundColor(.text)
                                .padding(.vertical, 4)
                            Spacer()
                        }
                        if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .text))
                                    .scaleEffect(1.5)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.episodes, id: \.id) { episode in
                                        EpisodeView(episode: episode)
                                            .padding(.horizontal, 4)
                                    }
                                }
                            }
                            .padding(8)
                        }

                        Text("details_created_at: \(viewModel.character.created.toHumanReadableDateTime())")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding()

                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        app.navigation.pop()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.text)
                    })
                }
            }
            .task {
                await viewModel.getEpisodeInfo()
            }
            .navigationTitle("details_character_title")
            .navigationBarTitleDisplayMode(.inline)
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
    DetailsScreen(character: DomainCharacter.mock(), repository: MockRickAndMortyRepository())
}
