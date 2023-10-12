import XCTest

final class HomeViewModelTests: XCTestCase {
    private var systemUnderTest: HomeViewModel? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    private func initSystemUnderTest(dataProvider: DataProviding) {
        let kitsuRepo = KitsuRepository(dataProvider: dataProvider)
        systemUnderTest = HomeViewModel(animeRepository: kitsuRepo)
        XCTAssertNotNil(systemUnderTest)
    }
    
    private func searchHomeViewModelWith(dataProvider: DataProviding) -> ([Anime], LocalizedError?) {
        initSystemUnderTest(dataProvider: dataProvider)
        systemUnderTest!.search(for: "")
        
        return (systemUnderTest!.animeSearchResults.value, systemUnderTest!.searchingError.value)
    }
    
    func testSuccessfulCallWithNotNullData() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = 3
        let actual = animeSearchResults.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(actual, expected)
    }
    
    func testSuccessfulCallWithNullData() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(dataProvider: AnimeTestDataProvider.nullKitsuSearchDataProvider)
        let expected = 0
        let actual = animeSearchResults.count

        XCTAssertNotNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeReturn() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = AnimeTestDataProvider.validAnimeInstance
        
        XCTAssertNil(searchingError)
        
        if animeSearchResults.count > 0 {
            let actual = animeSearchResults[0]
            XCTAssertEqual(expected, actual)
        } else {
            XCTFail("Unexpected empty anime result")
        }
    }
    
    func testSuccessfulAnimeReturnNoResults() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(dataProvider: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        let expected = 0
        let actual = animeSearchResults.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsuccessfulCall() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuSearchDataProvider)
        let expected = 0
        let actual = animeSearchResults.count
        
        XCTAssertNotNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
}
