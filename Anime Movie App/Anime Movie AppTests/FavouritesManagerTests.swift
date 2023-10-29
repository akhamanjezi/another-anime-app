import XCTest

final class FavouritesManagerTests: XCTestCase {
    private var systemUnderTest: FavouritesManager? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testWhenInitThenAllFavouritesEmpty() {
        initSystemUnderTest()
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenInitWithUnavailableStorageThenAllFavouritesEmpty() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenAddFavouriteWithUnavailableStorageThenAllFavouritesEmpty() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        
        let expected: [Anime] = []
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenAddFavouriteThenAllFavouritesContainsPlaceholder() {
        initSystemUnderTest()
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected = [Anime.placeholder]
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenRemoveFavouriteWithUnavailableStorageThenAllFavouritesEmpty() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenAddThenRemoveFavouriteThenAllFavouritesEmpty() {
        initSystemUnderTest()
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenAddFavouriteThenIsFavouriteTrue() {
        initSystemUnderTest()
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: Anime.placeholder.key)
        
        let expected = true
        let actual = systemUnderTest?.isFavourite(Anime.placeholder)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenInitThenIsFavouriteFalse() {
        initSystemUnderTest()
        
        let expected = false
        let actual = systemUnderTest?.isFavourite(Anime.placeholder)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenResetFavouritesThenAllFavouritesEmpty() {
        initSystemUnderTest()
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        systemUnderTest?.resetFavourites()
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testWhenResetFavouritesWithUnavailableStorageThenAllFavouritesEmpty() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        systemUnderTest?.resetFavourites()
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    private func initSystemUnderTest(storage: any DataStoring<String, Data> = FavouritesStorageFake()) {
        systemUnderTest = FavouritesManager(storage: storage)
    }
}
