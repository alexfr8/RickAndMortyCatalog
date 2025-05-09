import Foundation

public struct DataCharacterDetail: Codable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: DataOrigin
    public let location: DataOrigin
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    public init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: DataOrigin,
        location: DataOrigin,
        image: String,
        episode: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}
