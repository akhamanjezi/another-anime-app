import XCTest

final class KitsuResultToAnimeMapperTests: XCTestCase {
    private let systemUnderTest = KitsuResultToAnimeMapper()
    
    func testSuccessfulKitsuMapToAnime() {
        let expected = AnimeTestDataProvider.validAnimeInstance
        let actual = systemUnderTest.mapToAnime(from: AnimeTestDataProvider.validKitsuResult)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulKitsuMapToAnimeFallbackImages() {
        let expected = AnimeTestDataProvider.validAnimeInstanceFallbackImageInfo
        let actual = systemUnderTest.mapToAnime(from: AnimeTestDataProvider.validKitsuResultFallbackImages)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulKitsuMapToAnimeNilDuration() {
        let expected = AnimeTestDataProvider.validAnimeInstanceZeroDuration
        let actual = systemUnderTest.mapToAnime(from: AnimeTestDataProvider.validKitsuResultNilDuration)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsuccessfulKitsuMapToAnime() {
        let actual = systemUnderTest.mapToAnime(from: AnimeTestDataProvider.invalidKitsuResult)
        
        XCTAssertNil(actual)
    }
}
