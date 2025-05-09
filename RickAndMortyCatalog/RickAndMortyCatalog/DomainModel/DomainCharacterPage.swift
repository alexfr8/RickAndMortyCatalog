import Foundation

struct DomainCharacterPage: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    let results: [DomainCharacter]
}
