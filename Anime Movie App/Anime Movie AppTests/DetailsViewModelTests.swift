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
    
    // MARK: Favourites
    
    func testIsFavouriteFalse() {
        initSystemUnderTest()
        
        let expected = false
        let actual = systemUnderTest?.isFavourite
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsFavouriteTrue() {
        initSystemUnderTest(storage: AnimeTestDataProvider.validFavouritesDictionryDataStoragePopulated)
        
        let expected = true
        let actual = systemUnderTest?.isFavourite
        
        XCTAssertEqual(expected, actual)
    }
    
    func testToggleFavouriteTrue() {
        initSystemUnderTest()
        systemUnderTest?.toggleFavourite { [weak self] in
            let expected = true
            let actual = self?.systemUnderTest?.isFavourite
            
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testToggleFavouriteFalse() {
        initSystemUnderTest(storage: AnimeTestDataProvider.validFavouritesDictionryDataStoragePopulated)
        
        systemUnderTest?.toggleFavourite { [weak self] in
            let expected = false
            let actual = self?.systemUnderTest?.isFavourite
            
            XCTAssertEqual(expected, actual)
        }
    }
    
    private func initSystemUnderTest(anime: Anime = AnimeTestDataProvider.validAnimeInstance,
                                     searchTerm: String? = "Spirited Away",
                                     storage: any DataStoring<String, Data> = FavouritesStorageFake(),
                                     dataProvider: DataProviding = AnimeTestDataProvider.successfulKitsuSearchDataProvider) {
        let kitsuRepo = KitsuRepository(dataProvider: dataProvider,
                                        imageRepository: ImageRepository(imageDownloader: ImageDownloaderStub()),
                                        favouritesManager: FavouritesManager(storage: storage))
        
        systemUnderTest = DetailsViewModel(animeRepository: kitsuRepo,
                                           anime: anime,
                                           searchTerm: searchTerm)
        
        XCTAssertNotNil(systemUnderTest)
    }
}
