import Foundation

public extension DataOrigin {
    static func mock(
        name: String = "Earth",
        url: String = "https://rickandmortyapi.com/api/location/1"
    ) -> DataOrigin {
        return DataOrigin(
            name: name,
            url: url
        )
    }
}
