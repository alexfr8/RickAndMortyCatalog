import SwiftUI

struct DetailssScreenContainer: View {
    @Environment(\.app) private var app

    var body: some View {
        DetailsScreen()
    }
}

struct DetailsScreen: View {
    @Environment(\.app) private var app
    @StateObject private var viewModel: DetailsScreenViewModel

    init() {
        _viewModel = StateObject(wrappedValue: DetailsScreenViewModel())
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Detail")
        }
    }
}

#Preview {
    DetailsScreen()
}
