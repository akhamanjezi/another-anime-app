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
    
    func testWhenInitedThenFavouriteFalse() {
        initSystemUnderTest()
        
        let expected = false
        let actual = systemUnderTest?.isFavourite
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenInitedWithFavouriteThenFavouriteTrue() {
        initSystemUnderTest(storage: AnimeTestDataProvider.validFavouritesDictionryDataStoragePopulated)
        
        let expected = true
        let actual = systemUnderTest?.isFavourite
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenToggleFavouriteOfNotFavouriteThenTrue() {
        initSystemUnderTest()
        systemUnderTest?.toggleFavourite()
        
        let expected = true
        let actual = systemUnderTest?.isFavourite
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenToggleFavouriteOfFavouriteThenFalse() {
        initSystemUnderTest(storage: AnimeTestDataProvider.validFavouritesDictionryDataStoragePopulated)
        systemUnderTest?.toggleFavourite()
        
        let expected = false
        let actual = systemUnderTest?.isFavourite
        
        XCTAssertEqual(expected, actual)
    }
    
    private func initSystemUnderTest(anime: Anime = AnimeTestDataProvider.validAnimeInstance,
                                     searchTerm: String? = "Spirited Away",
                                     storage: any DataStoring<String, Data> = FavouritesStorageFake(),
                                     dataProvider: DataProviding = AnimeTestDataProvider.successfulKitsuSearchDataProvider) {
        let kitsuRepo = KitsuRepository(dataProvider: dataProvider,
                                        imageRepository: ImageRepo(imageDownloader: ImageDownloaderStub()),
                                        favouritesManager: FavouritesManager(storage: storage))
        
        systemUnderTest = DetailsViewModel(anime: anime,
                                           animeRepository: kitsuRepo,
                                           searchTerm: searchTerm)
        
        XCTAssertNotNil(systemUnderTest)
    }
}
