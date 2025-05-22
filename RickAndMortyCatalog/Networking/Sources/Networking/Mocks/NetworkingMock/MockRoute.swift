import Foundation

struct MockRoute: NetworkRoute {
    var path: String = "/mock"
    var queryItems: [String : Any] = [:]
    var body: Data? = nil
    var type: NetworkRequestType = .get

    var baseUrl: String {
        "https://example.com"
    }
}
