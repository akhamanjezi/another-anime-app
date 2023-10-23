import XCTest

final class HomeViewModelTests: XCTestCase {
    private var systemUnderTest: HomeViewModel? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testSuccessfulAnimeByIdWithNotNullData() {
        newFeatureAnime(with: AnimeTestDataProvider.successfulKitsuAnimeByIDDataProvider)
        
        let actual = systemUnderTest?.featureAnime.value
        
        XCTAssertNotNil(actual)
    }
    
    func testSuccessfulAnimeByIdWithNullData() {
        newFeatureAnime(with: AnimeTestDataProvider.nullKitsuDataProvider)
        
        let expected = LocalizedError.invalidResponse
        let actual = systemUnderTest?.fetchingError.value
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeByIdAnimeReturn() {
        newFeatureAnime(with: AnimeTestDataProvider.successfulKitsuAnimeByIDDataProvider)
        
        let expected = AnimeTestDataProvider.validAnimeInstance
        let actual = systemUnderTest?.featureAnime.value
        let fetchingError = systemUnderTest?.fetchingError.value
        
        XCTAssertNil(fetchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeByIdAnimeReturnNoResults() {
        newFeatureAnime(with: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        
        let expected = LocalizedError.invalidResponse
        let actual = systemUnderTest?.fetchingError.value
        
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsuccessfulAnimeById() {
        newFeatureAnime(with: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        
        let expected = LocalizedError.invalidRequest
        let actual = systemUnderTest?.fetchingError.value
        
        XCTAssertEqual(expected, actual)
    }
    
    private func newFeatureAnime(with dataProvider: DataProviding) {
        initSystemUnderTest(dataProvider: dataProvider)
        systemUnderTest!.newFeatureAnime()
    }
    
    private func initSystemUnderTest(dataProvider: DataProviding) {
        let kitsuRepo = KitsuRepository(dataProvider: dataProvider, imageRepository: ImageRepository(imageDownloader: ImageDownloaderStub()))
        
        systemUnderTest = HomeViewModel(animeRepository: kitsuRepo)
        
        XCTAssertNotNil(systemUnderTest)
    }
}
