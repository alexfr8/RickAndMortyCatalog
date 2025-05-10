import SwiftUI

struct EpisodeView: View {
    let episode: DomainEpisodeDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(episode.name)
                .font(.headline)
                .foregroundColor(.text)

            Text(episode.episode)
                .foregroundColor(.textSecondary)

            Text("episode_air_date: \(episode.airDate)")
                .font(.subheadline)
                .foregroundColor(.textSecondary)
        }
        .padding(8)
        .frame(maxWidth: 300, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    EpisodeView(episode: DomainEpisodeDetail.mock())
        .padding()
        .background(Color.black)
}
