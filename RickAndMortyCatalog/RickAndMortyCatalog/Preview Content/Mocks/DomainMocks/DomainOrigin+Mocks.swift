import Foundation

extension DomainOrigin {
    static func mock(
        name: String = "Earth (C-137)",
        url: String = "https://rickandmortyapi.com/api/location/1"
    ) -> DomainOrigin {
        return DomainOrigin(
            name: name,
            url: url
        )
    }
}
