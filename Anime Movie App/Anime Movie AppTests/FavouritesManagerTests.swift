import XCTest

final class FavouritesManagerTests: XCTestCase {
    private var systemUnderTest: FavouritesManager? = nil
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testAllFavourites() {
        initSystemUnderTest()
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAllFavouritesNilStorage() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddFavouriteFailure() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        
        let expected: [Anime] = []
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddFavourite() {
        initSystemUnderTest()
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected = [Anime.placeholder]
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddFavouriteNilStorage() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveFavouriteFailure() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageStub())
        systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveFavourite() {
        initSystemUnderTest()
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsFavouriteTrue() {
        initSystemUnderTest()
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: Anime.placeholder.key)
        
        let expected = true
        let actual = systemUnderTest?.isFavourite(Anime.placeholder)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsFavouriteFalse() {
        initSystemUnderTest()
        
        let expected = false
        let actual = systemUnderTest?.isFavourite(Anime.placeholder)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testResetFavourites() {
        initSystemUnderTest()
        
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        systemUnderTest?.resetFavourites()
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testResetFavouritesNilStorage() {
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
