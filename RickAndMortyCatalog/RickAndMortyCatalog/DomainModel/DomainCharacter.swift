import Foundation

struct DomainCharacter: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: DomainOrigin
    let location: DomainOrigin
    let image: String
    let episode: [String]
    let url: String
    let created: Date
}
