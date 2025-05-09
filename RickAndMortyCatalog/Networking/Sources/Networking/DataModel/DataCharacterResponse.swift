import Foundation

public struct DataCharacterResponse: Codable, Sendable {
    public let info: DataInfo
    public let results: [DataCharacterDetail]

    public init(info: DataInfo, results: [DataCharacterDetail]) {
        self.info = info
        self.results = results
    }
}
