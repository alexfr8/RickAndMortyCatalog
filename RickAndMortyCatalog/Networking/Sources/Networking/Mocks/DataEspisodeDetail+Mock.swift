import Foundation

extension DataEpisodeDetail {
    public static func mock(
        id: Int = 1,
        name: String = "Pilot",
        airDate: String = "December 2, 2013",
        episode: String = "S01E01",
        characters: [String] = ["https://rickandmortyapi.com/api/character/1"],
        url: String = "https://rickandmortyapi.com/api/episode/1",
        created: String = "2017-11-10T12:56:33.798Z"
    ) -> DataEpisodeDetail {
        return DataEpisodeDetail(
            id: id,
            name: name,
            episode: episode,
            airDate: airDate,
            characters: characters,
            url: url,
            created: created
        )
    }

    public static func mockList(count: Int = 5) -> [DataEpisodeDetail] {
        return (1...count).map { index in
            DataEpisodeDetail.mock(
                id: index,
                name: "Episode \(index)",
                airDate: "December \(index), 2013",
                episode: "S01E0\(index)",
                characters: (1...3).map { "https://rickandmortyapi.com/api/character/\($0 + index)" },
                url: "https://rickandmortyapi.com/api/episode/\(index)",
                created: "2017-11-10T12:56:33.798Z"
            )
        }
    }
}
