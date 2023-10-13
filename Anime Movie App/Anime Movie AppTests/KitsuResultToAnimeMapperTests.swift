import XCTest

final class KitsuResultToAnimeMapperTests: XCTestCase {
    private let systemUnderTest = KitsuResultToAnimeMapper()
    
    func testSuccessfulKitsuMapToAnime() throws {
        let expected = AnimeTestDataProvider.validAnimeInstance
        let actual = systemUnderTest.mapToAnime(from: AnimeTestDataProvider.validKitsuResult)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsccessfulKitsuMapToAnime() throws {
        let actual = systemUnderTest.mapToAnime(from: AnimeTestDataProvider.invalidKitsuResult)
        
        XCTAssertNil(actual)
    }
}
