import Foundation

struct DomainEpisode: Identifiable, Codable {
    let id: Int
    let name: String
    let episode: String
    let airDate: String
}
