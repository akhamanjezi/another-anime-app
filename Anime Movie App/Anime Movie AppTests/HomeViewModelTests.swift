import XCTest

final class HomeViewModelTests: XCTestCase {
    private var systemUnderTest: HomeViewModel? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testSuccessfulAnimeByIdWithNotNullData() throws {
        newFeatureAnime(with: AnimeTestDataProvider.successfulKitsuAnimeByIDDataProvider)
        
        let actual = systemUnderTest?.featureAnime.value
        
        XCTAssertNotNil(actual)
    }
    
    func testSuccessfulAnimeByIdWithNullData() throws {
        newFeatureAnime(with: AnimeTestDataProvider.nullKitsuDataProvider)
        
        let expected = LocalizedError.invalidResponse
        let actual = systemUnderTest?.fetchingError.value
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeByIdAnimeReturn() throws {
        newFeatureAnime(with: AnimeTestDataProvider.successfulKitsuAnimeByIDDataProvider)
        
        let expected = AnimeTestDataProvider.validAnimeInstance
        let actual = systemUnderTest?.featureAnime.value
        let fetchingError = systemUnderTest?.fetchingError.value
        
        XCTAssertNil(fetchingError)
        XCTAssertEqual(expected, actual)
    }
    
    func testSuccessfulAnimeByIdAnimeReturnNoResults() throws {
        newFeatureAnime(with: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        
        let expected = LocalizedError.invalidResponse
        let actual = systemUnderTest?.fetchingError.value
        
        XCTAssertEqual(expected, actual)
    }
    
    func testUnsuccessfulAnimeById() throws {
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
        let kitsuRepo = KitsuRepository(dataProvider: dataProvider)
        
        systemUnderTest = HomeViewModel(animeRepository: kitsuRepo, imageRepository: ImageRepository(imageDownloader: ImageDownloaderStub()))
        
        XCTAssertNotNil(systemUnderTest)
    }
}
