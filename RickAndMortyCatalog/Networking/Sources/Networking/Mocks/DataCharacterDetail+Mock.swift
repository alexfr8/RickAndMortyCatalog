import Foundation

extension DataCharacterDetail {
    public static func mock(
        id: Int = 1,
        name: String = "Rick Sanchez",
        status: String = "Alive",
        species: String = "Human",
        type: String = "",
        gender: String = "Male",
        origin: DataOrigin = DataOrigin.mock(),
        location: DataOrigin = DataOrigin.mock(),
        image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [String] = ["https://rickandmortyapi.com/api/episode/1"],
        url: String = "https://rickandmortyapi.com/api/character/1",
        created: String = "2017-11-04T18:48:46.250Z"
    ) -> DataCharacterDetail {
        return DataCharacterDetail(
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

    public static func mockList(count: Int = 5) -> [DataCharacterDetail] {
        return (1...count).map { index in
            DataCharacterDetail.mock(
                id: index,
                name: "Character \(index)",
                status: index % 2 == 0 ? "Alive" : "Dead",
                species: "Species \(index)",
                type: "Type \(index)",
                gender: index % 2 == 0 ? "Male" : "Female",
                origin: .mock(
                    name: "Origin \(index)",
                    url: "https://rickandmortyapi.com/api/location/\(index)"
                ),
                location: .mock(
                    name: "Location \(index)",
                    url: "https://rickandmortyapi.com/api/location/\(index + 10)"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/\(index).jpeg",
                episode: (1...3).map { "https://rickandmortyapi.com/api/episode/\($0 + index)"
                },
                url: "https://rickandmortyapi.com/api/character/\(index)",
                created: "2017-11-04T18:48:46.250Z"
            )
        }
    }
}
