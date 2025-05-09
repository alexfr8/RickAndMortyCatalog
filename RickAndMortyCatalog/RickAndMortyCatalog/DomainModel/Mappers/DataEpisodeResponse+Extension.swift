import Foundation
import Networking

extension DataEpisodeDetail {
    func toDomain() -> DomainEpisodeDetail {
        DomainEpisodeDetail(
            id: self.id,
            name: self.name,
            episode: self.episode,
            airDate: self.airDate,
            characters: self.characters,
            url: self.url,
            created: self.created
        )
    }
}

extension [DataEpisodeDetail] {
    func toDomain() -> [DomainEpisodeDetail] {
        self.map { episode in
            episode.toDomain()
        }
    }
}
