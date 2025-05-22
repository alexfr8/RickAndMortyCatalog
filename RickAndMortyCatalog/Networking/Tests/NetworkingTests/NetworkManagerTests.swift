//import XCTest
//@testable import RickAndMortyCatalog
//
//final class NetworkManagerTests: XCTestCase {
//    var sut: NetworkManager!
//    var session: URLSession!
//
//    override func setUp() {
//        super.setUp()
//
//        let config = URLSessionConfiguration.ephemeral
//        config.protocolClasses = [MockURLProtocol.self] // Intercept requests
//        session = URLSession(configuration: config)
//
//        sut = NetworkManager(urlSession: session)
//    }
//
//    override func tearDown() {
//        sut = nil
//        session = nil
//        MockURLProtocol.requestHandler = nil
//        super.tearDown()
//    }
//
//    func test_performRequest_success_returnsData() async throws {
//        // Given
//        let expectedData = "Mock Response".data(using: .utf8)!
//        MockURLProtocol.requestHandler = { request in
//            let response = HTTPURLResponse(
//                url: request.url!,
//                statusCode: 200,
//                httpVersion: nil,
//                headerFields: nil
//            )!
//            return (expectedData, response)
//        }
//
//        let route = MockRoute()
//
//        // When
//        let result = try await sut.performRequest(with: route)
//
//        // Then
//        XCTAssertEqual(result, expectedData)
//    }
//
//    func test_performRequest_withClientError_throwsClientError() async {
//        // Given
//        MockURLProtocol.requestHandler = { request in
//            let response = HTTPURLResponse(
//                url: request.url!,
//                statusCode: 404,
//                httpVersion: nil,
//                headerFields: nil
//            )!
//            return (Data(), response)
//        }
//
//        let route = MockRoute()
//
//        // Then
//        await XCTAssertThrowsErrorAsync {
//            _ = try await sut.performRequest(with: route)
//        }
//    }
//
//    func test_performRequest_invalidURL_throwsWrongUrl() async {
//        // Given
//        struct InvalidRoute: NetworkRoute {
//            var baseUrl: String { "ht$tp://😅" }
//            var path: String = "/invalid"
//            var queryItems: [String : Any] = [:]
//            var body: Data? = nil
//            var type: NetworkRequestType = .get
//        }
//
//        let route = InvalidRoute()
//
//        // Then
//        await XCTAssertThrowsErrorAsync {
//            _ = try await sut.performRequest(with: route)
//        }
//    }
//}
//
//extension XCTestCase {
//    func XCTAssertThrowsErrorAsync<T>(
//        _ expression: @autoclosure @escaping () async throws -> T,
//        file: StaticString = #file,
//        line: UInt = #line
//    ) async {
//        do {
//            _ = try await expression()
//            XCTFail("Expected error to be thrown", file: file, line: line)
//        } catch {
//            // success
//        }
//    }
//}
