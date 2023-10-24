import XCTest

final class StoringAnimeTests: XCTestCase {
    private var systemUnderTest: StoringAnime? = nil
    
    func testComparableAscending() {
        let expected: [StoringAnime] = [AnimeTestDataProvider.animeFavouritedInTheDistantPast, AnimeTestDataProvider.animeFavouritedNow, AnimeTestDataProvider.animeFavouritedInTheDistantFuture]
        let actual = expected.shuffled().sorted(by: <)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testComparableDescending() {
        let expected: [StoringAnime] = [AnimeTestDataProvider.animeFavouritedInTheDistantFuture, AnimeTestDataProvider.animeFavouritedNow, AnimeTestDataProvider.animeFavouritedInTheDistantPast]
        let actual = expected.shuffled().sorted(by: >)
        
        XCTAssertEqual(expected, actual)
    }
}
