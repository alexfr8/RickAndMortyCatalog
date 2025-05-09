import Foundation

public struct DomainEpisodeDetail: Codable, Sendable {
    public let id: Int
    public let name: String
    public let episode: String
    public let airDate: String
    public let characters: [String]
    public let url: String
    public let created: String
}
