import Foundation

extension DomainCharacter {
    static func mock(
        id: Int = 1,
        name: String = "Character 1",
        status: String = "Alive",
        species: String = "Human",
        type: String = "",
        gender: String = "Male",
        origin: DomainOrigin = .mock(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
        location: DomainOrigin = .mock(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
        image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [String] = ["https://rickandmortyapi.com/api/episode/1"],
        url: String = "https://rickandmortyapi.com/api/character/1",
        created: Date = Date()
    ) -> DomainCharacter {
        return DomainCharacter(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }

    static func mockList(count: Int = 5) -> [DomainCharacter] {
        return (1...count).map { index in
            DomainCharacter.mock(
                id: index,
                name: "Character \(index)",
                status: index % 2 == 0 ? "Alive" : "Dead",
                species: "Species \(index)",
                type: "Type \(index)",
                gender: index % 2 == 0 ? "Male" : "Female",
                origin: .mock(name: "Origin \(index)", url: "https://api/location/\(index)"),
                location: .mock(name: "Location \(index)", url: "https://api/location/\(index + 10)"),
                image: "https://example.com/image\(index).png",
                episode: (1...3).map { "https://api/episode/\($0 + index)" },
                url: "https://api/character/\(index)",
                created: Date()
            )
        }
    }
}
