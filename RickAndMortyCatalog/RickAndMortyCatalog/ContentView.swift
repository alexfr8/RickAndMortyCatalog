import SwiftUI
import Networking

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            Task {
                let networkClient: RickAndMortyServiceProtocol = RickAndMortyService()
                let value = try await networkClient.fetchCharacters(page: 1)
                print(value)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
