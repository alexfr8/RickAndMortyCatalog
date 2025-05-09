import Foundation

struct DomainEpisodePage: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    let results: [DomainEpisode]
}
