import XCTest

final class KitsuRepositoryTests: XCTestCase {
    private var systemUnderTest: KitsuRepository? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    // MARK: Search
    
    func testSuccessfulSearchWithNotNullData() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(let actual):
                XCTAssertNotNil(actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testSuccessfulSearchWithNullData() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.nullKitsuDataProvider)
        
        let expected = LocalizedError.invalidResponse
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
        }
    }
    
    func testSuccessfulSearchAnimeReturn() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        
        let expected = AnimeTestDataProvider.validAnimeInstance
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(let data):
                let actual = data.results[0]
                XCTAssertEqual(expected, actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testSuccessfulSearchAnimeReturnNoResults() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        
        let expected = 0
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(let search):
                let actual = search.results.count
                XCTAssertEqual(expected, actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testUnsuccessfulSearch() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        
        let expected = LocalizedError.invalidRequest
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
        }
    }
    
    func testSuccessfulSearchAnimeReturnNilData() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulNilDataKitsuSearchDataProvider)
        
        let expected: [Anime] = []
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(let result):
                let actual = result.results
                XCTAssertEqual(expected, actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    // MARK: Anime by ID
    
    func testSuccessfulAnimeByIdWithNotNullData() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuAnimeByIDDataProvider)
        
        systemUnderTest?.anime(by: "") { result in
            switch result {
            case .success(let actual):
                XCTAssertNotNil(actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testSuccessfulAnimeByIdWithNullData() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.nullKitsuDataProvider)
        
        let expected = LocalizedError.invalidResponse
        
        systemUnderTest?.anime(by: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
        }
    }
    
    func testSuccessfulAnimeByIdAnimeReturn() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuAnimeByIDDataProvider)
        
        let expected = AnimeTestDataProvider.validAnimeInstance
        
        systemUnderTest?.anime(by: "") { result in
            switch result {
            case .success(let data):
                let actual = data
                XCTAssertEqual(expected, actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testSuccessfulAnimeByIdAnimeReturnNoResults() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        
        let expected = LocalizedError.invalidResponse
        
        systemUnderTest?.anime(by: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
        }
    }
    
    func testUnsuccessfulAnimeById() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuDataProvider)
        
        let expected = LocalizedError.invalidRequest
        
        systemUnderTest?.anime(by: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
        }
    }
    
    func testSuccessfulAnimeByIdAnimeReturnNilData() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulNilDataKitsuAnimeByIDDataProvider)
        
        let expected = LocalizedError.invalidResponse
        
        systemUnderTest?.anime(by: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let actual):
                XCTAssertEqual(expected, actual)
            }
        }
    }
    
    // MARK: Image Download
    
    func testSuccessfulCoverImageDownload() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = AnimeTestDataProvider.spiritedAwayCoverImage
        
        systemUnderTest?.downloadImage(.cover, for: AnimeTestDataProvider.validAnimeInstance) { image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testSuccessfulPosterImageDownload() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        let expected = AnimeTestDataProvider.spiritedAwayPosterImage
        
        systemUnderTest?.downloadImage(.poster, for: AnimeTestDataProvider.validAnimeInstance) { image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testUnsuccessfulCoverImageDownload() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        
        systemUnderTest?.downloadImage(.cover, for: AnimeTestDataProvider.validAnimeInstanceNoImageInfo) { image in
            let actual = image
            XCTAssertNil(actual)
        }
    }
    
    func testUnsuccessfulPosterImageDownload() {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        
        systemUnderTest?.downloadImage(.poster, for: AnimeTestDataProvider.validAnimeInstanceNoImageInfo) { image in
            let actual = image
            XCTAssertNil(actual)
        }
    }
    
    // MARK: Favourites
    
    func testIsFavouriteFalse() {
        initSystemUnderTest()
        
        let expected = false
        let actual = systemUnderTest?.isFavourite(AnimeTestDataProvider.validAnimeInstance)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsFavouriteTrue() {
        initSystemUnderTest(storage: AnimeTestDataProvider.validFavouritesDictionryDataStoragePopulated)
        
        let expected = true
        let actual = systemUnderTest?.isFavourite(AnimeTestDataProvider.validAnimeInstance)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testToggleFavouriteTrue() {
        initSystemUnderTest()
        systemUnderTest?.toggleFavourite(AnimeTestDataProvider.validAnimeInstance)
        
        let expected = true
        let actual = systemUnderTest?.isFavourite(AnimeTestDataProvider.validAnimeInstance)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testToggleFavouriteFalse() {
        initSystemUnderTest(storage: AnimeTestDataProvider.validFavouritesDictionryDataStoragePopulated)
        systemUnderTest?.toggleFavourite(AnimeTestDataProvider.validAnimeInstance)
        
        let expected = false
        let actual = systemUnderTest?.isFavourite(AnimeTestDataProvider.validAnimeInstance)
        
        XCTAssertEqual(expected, actual)
    }
    
    // MARK: Helper Functions
    
    private func initSystemUnderTest(dataProvider: DataProviding = AnimeTestDataProvider.successfulKitsuSearchDataProvider,
                                     storage: any DataStoring<String, Data> = FavouritesStorageFake()) {
        systemUnderTest = KitsuRepository(dataProvider: dataProvider,
                                          imageRepository: ImageRepo(imageDownloader: ImageDownloaderStub()),
                                          favouritesManager: FavouritesManager(storage: storage))
        XCTAssertNotNil(systemUnderTest)
    }
}
