import Foundation

extension DataCharacterResponse {
    public static func mock(
        info: DataInfo = DataInfo.mock(),
        results: [DataCharacterDetail] = DataCharacterDetail.mockList()
    ) -> DataCharacterResponse {
        return DataCharacterResponse(
            info: info,
            results: results
        )
    }
}
