import Foundation

extension DomainEpisodeDetail {
    static func mock(
        id: Int = 1,
        name: String = "Pilot",
        airDate: String = "December 2, 2013",
        episode: String = "S01E01",
        characters: [String] = [],
        url: String = "https://rickandmortyapi.com/api/episode/51",
        created: String = "2021-11-02T14:07:57.818Z"
    ) -> DomainEpisodeDetail {
        return DomainEpisodeDetail(
            id: id,
            name: name,
            episode: episode,
            airDate: airDate,
            characters: characters,
            url: url,
            created: created
        )
    }

    static func mockList(count: Int = 5) -> [DomainEpisodeDetail] {
        return (1...count).map { index in
            DomainEpisodeDetail.mock(
                id: index,
                name: "Episode \(index)",
                airDate: "2023-01-\(String(format: "%02d", index))",
                episode: "S01E\(String(format: "%02d", index))"
            )
        }
    }
}
