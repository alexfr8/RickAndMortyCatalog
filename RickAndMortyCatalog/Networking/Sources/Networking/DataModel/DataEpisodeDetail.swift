import Foundation

public struct DataEpisodeDetail: Codable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let episode: String
    public let airDate: String
    public let characters: [String]
    public let url: String
    public let created: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }

    public init(
        id: Int,
        name: String,
        episode: String,
        airDate: String,
        characters: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.name = name
        self.episode = episode
        self.airDate = airDate
        self.characters = characters
        self.url = url
        self.created = created
    }
}
