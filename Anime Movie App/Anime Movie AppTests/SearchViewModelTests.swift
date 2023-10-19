import XCTest

final class SearchViewModelTests: XCTestCase {
    private var systemUnderTest: SearchViewModel? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testSuccessfulCallWithNotNullData() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = 3
        let actual = animeSearchResults.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulCallWithNullData() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.nullKitsuDataProvider)
        let expected = 0
        let actual = animeSearchResults.count
        
        XCTAssertNotNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeReturn() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = AnimeTestDataProvider.validAnimeInstance
        
        XCTAssertNil(searchingError)
        
        guard animeSearchResults.count > 0 else {
            XCTFail("Unexpected empty anime result")
            return
        }
        
        let actual = animeSearchResults[0]
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeReturnNoResults() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        let expected = 0
        let actual = animeSearchResults.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsuccessfulCall() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        let expected = 0
        let actual = animeSearchResults.count
        
        XCTAssertNotNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testCancelSearchClearsResults() {
        let (animeSearchResults, _) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        
        var expected = 3
        var actual: Int? = animeSearchResults.count
        XCTAssertEqual(expected, actual)
        
        systemUnderTest?.cancelSearch()
        
        expected = 0
        actual = systemUnderTest?.animeSearchResults.value.count
        XCTAssertEqual(expected, actual)
    }
    
    func testCancelSearchClearsError() {
        let (_, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        
        var actual = searchingError
        XCTAssertNotNil(actual)
        
        systemUnderTest?.cancelSearch()
        
        actual = systemUnderTest?.searchingError.value
        XCTAssertNil(actual)
    }
    
    func testSuccessfulImageDownload() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = AnimeTestDataProvider.spiritedAwayPosterImage
        
        systemUnderTest?.downloadImage(for: AnimeTestDataProvider.validAnimeInstance) { image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testUnSuccessfulImageDownload() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = AnimeTestDataProvider.popcornPlaceholderImage
        
        systemUnderTest?.downloadImage(for: AnimeTestDataProvider.validAnimeInstanceNoImageInfo) { image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    private func initSystemUnderTest(dataProvider: DataProviding) {
        let kitsuRepo = KitsuRepository(dataProvider: dataProvider, imageRepository: ImageRepository(imageDownloader: ImageDownloaderStub()))
        systemUnderTest = SearchViewModel(animeRepository: kitsuRepo)
        XCTAssertNotNil(systemUnderTest)
    }
    
    private func searchSearchViewModelWith(dataProvider: DataProviding) -> ([Anime], LocalizedError?) {
        initSystemUnderTest(dataProvider: dataProvider)
        systemUnderTest!.search(for: "")
        
        return (systemUnderTest!.animeSearchResults.value, systemUnderTest!.searchingError.value)
    }
}
