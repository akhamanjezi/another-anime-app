import XCTest

final class SavedAnimeTests: XCTestCase {
    private var systemUnderTest: SavedAnime? = nil
    
    func testComparableAscending() {
        let expected: [SavedAnime] = [AnimeTestDataProvider.animeFavouritedInTheDistantPast, AnimeTestDataProvider.animeFavouritedNow, AnimeTestDataProvider.animeFavouritedInTheDistantFuture]
        let actual = expected.shuffled().sorted(by: <)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testComparableDescending() {
        let expected: [SavedAnime] = [AnimeTestDataProvider.animeFavouritedInTheDistantFuture, AnimeTestDataProvider.animeFavouritedNow, AnimeTestDataProvider.animeFavouritedInTheDistantPast]
        let actual = expected.shuffled().sorted(by: >)
        
        XCTAssertEqual(expected, actual)
    }
}
