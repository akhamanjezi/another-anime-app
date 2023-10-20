import XCTest

final class DetailsViewModelTests: XCTestCase {
    private var systemUnderTest: DetailsViewModel? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testSuccessfulInitWithoutSearchTerm() {
        initSystemUnderTest()
        
        let expected = AnimeTestDataProvider.validAnimeInstance
        let actual = systemUnderTest?.anime.value
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulInitWithSearchTerm() {
        initSystemUnderTest()
        
        let expected = "Spirited Away"
        let actual = systemUnderTest?.searchTerm
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCorrectSectionsIfSynopsisNotNil() {
        initSystemUnderTest()
        let expected = ["Header", "Synopsis"]
        let actual = systemUnderTest?.sections
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCorrectSectionsIfSynopsisNil() {
        initSystemUnderTest(anime: AnimeTestDataProvider.animeInstanceNilSynopsis)
        let expected = ["Header"]
        let actual = systemUnderTest?.sections
        
        XCTAssertEqual(expected, actual)
    }
    
    private func initSystemUnderTest(anime: Anime = AnimeTestDataProvider.validAnimeInstance, searchTerm: String? = "Spirited Away") {
        systemUnderTest = DetailsViewModel(anime: anime, searchTerm: searchTerm)
        
        XCTAssertNotNil(systemUnderTest)
    }
}
