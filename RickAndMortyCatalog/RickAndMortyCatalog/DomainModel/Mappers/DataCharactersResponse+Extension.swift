import Foundation
import Networking

extension DataCharacterResponse {
    func toDomain() -> DomainCharacterPage {
        DomainCharacterPage(
            count: self.info.count,
            pages: self.info.pages,
            next: self.info.next,
            prev: self.info.prev,
            results: self.results.toDomain()
        )
    }
}

extension [DataCharacterDetail] {
    func toDomain() -> [DomainCharacter] {
        self.map { character in
            character.toDomain()
        }
    }
}

extension DataOrigin {
    func toDomain() -> DomainOrigin {
        DomainOrigin(
            name: self.name,
            url: self.url
        )
    }
}

extension DataCharacterDetail {
    func toDomain() -> DomainCharacter {
        DomainCharacter(
            id: self.id,
            name: self.name,
            status: self.status,
            species: self.species,
            type: self.type,
            gender: self.gender,
            origin: self.origin.toDomain(),
            location: self.location.toDomain(),
            image: self.image,
            episode: self.episode,
            url: self.url,
            created: self.created.toDateFromISO8601()
        )
    }
}
