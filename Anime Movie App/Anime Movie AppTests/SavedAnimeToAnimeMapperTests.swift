import XCTest

final class SavedAnimeToAnimeMapperTests: XCTestCase {
    private let systemUnderTest = SavedAnimeToAnimeMapper()
    
    func testSuccessfulMapToAnime() {
        let expected = AnimeTestDataProvider.validAnimeInstance
        let actual = systemUnderTest.mapToAnime(from: AnimeTestDataProvider.animeFavouritedNow)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulMapFromAnime() {
        let expected = AnimeTestDataProvider.animeFavouritedNow
        let actual = systemUnderTest.mapFromAnime(AnimeTestDataProvider.validAnimeInstance)
        
        XCTAssertEqual(expected, actual)
    }
}
