import Foundation

public struct DataInfo: Codable, Sendable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?

    public init(count: Int, pages: Int, next: String?, prev: String?) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}
