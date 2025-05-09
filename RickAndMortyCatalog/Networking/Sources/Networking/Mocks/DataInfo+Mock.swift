import Foundation

extension DataInfo {
    public static func mock(
        count: Int = 826,
        pages: Int = 42,
        next: String? = "https://rickandmortyapi.com/api/character?page=2",
        prev: String? = nil
    ) -> DataInfo {
        return DataInfo(
            count: count,
            pages: pages,
            next: next,
            prev: prev
        )
    }
}
