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
        let actual = animeSearchResults?.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulCallWithNullData() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.nullKitsuDataProvider)
        let actual = animeSearchResults?.count
        
        XCTAssertNotNil(searchingError)
        XCTAssertNil(actual)
    }
    
    func testSuccessfulAnimeReturn() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = AnimeTestDataProvider.validAnimeInstance
        
        XCTAssertNil(searchingError)
        
        guard let animeSearchResults = animeSearchResults,
              animeSearchResults.count > 0 else {
            XCTFail("Unexpected empty anime result")
            return
        }
        
        let actual = animeSearchResults[0]
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeReturnNoResults() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        let expected = 0
        let actual = animeSearchResults?.count
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsuccessfulCall() {
        let (animeSearchResults, searchingError) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        let actual = animeSearchResults?.count
        
        XCTAssertNotNil(searchingError)
        XCTAssertNil(actual)
    }
    
    func testCancelSearchClearsResults() {
        let (_, _) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        
        systemUnderTest?.cancelSearch()
        let actual = systemUnderTest?.animeSearchResults.value["spirited away"]?.count
        
        XCTAssertNil(actual)
    }
    
    func testCancelSearchClearsError() {
        let (_, _) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        
        systemUnderTest?.cancelSearch()
        let actual = systemUnderTest?.searchingError.value
        
        XCTAssertNil(actual)
    }
    
    func testRepeatSearchUsesDictionaryLookup() {
        let (_, _) = searchSearchViewModelWith(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = 3
        
        systemUnderTest?.search(for: "spirited away")
        let actual = systemUnderTest?.animeSearchResults.value["spirited away"]?.count
        
        XCTAssertEqual(expected, actual)
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
    
    private func searchSearchViewModelWith(dataProvider: DataProviding) -> ([Anime]?, LocalizedError?) {
        initSystemUnderTest(dataProvider: dataProvider)
        systemUnderTest!.search(for: "spirited away")
        
        return (systemUnderTest!.animeSearchResults.value["spirited away"], systemUnderTest!.searchingError.value)
    }
}
