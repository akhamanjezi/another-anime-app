import XCTest

final class SearchViewModelTests: XCTestCase {
    private var systemUnderTest: SearchViewModel? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testSuccessfulCallWithNotNullData() throws {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = 3
        let actual = animeSearchResults.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulCallWithNullData() throws {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.nullKitsuDataProvider)
        let expected = 0
        let actual = animeSearchResults.count

        XCTAssertNotNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeReturn() throws {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
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
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        let expected = 0
        let actual = animeSearchResults.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsuccessfulCall() throws {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        let expected = 0
        let actual = animeSearchResults.count
        
        XCTAssertNotNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    private func initSystemUnderTest(dataProvider: DataProviding) {
        let kitsuRepo = KitsuRepository(dataProvider: dataProvider)
        systemUnderTest = SearchViewModel(animeRepository: kitsuRepo, imageRepository: ImageRepository(imageDownloader: ImageDownloaderStub()))
        XCTAssertNotNil(systemUnderTest)
    }
    
    private func searchSearchViewModelWith(dataProvider: DataProviding) -> ([Anime], LocalizedError?) {
        initSystemUnderTest(dataProvider: dataProvider)
        systemUnderTest!.search(for: "")
        
        return (systemUnderTest!.animeSearchResults.value, systemUnderTest!.searchingError.value)
    }
}
