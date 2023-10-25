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
        initSystemUnderTest(storage: UnavailableFavouritesStorageFake())
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddFavouriteSuccess() {
        initSystemUnderTest()
        
        let expected = true
        let actual = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddFavouriteFailure() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageFake())
        
        let expected = false
        let actual = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddFavourite() {
        initSystemUnderTest()
        
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected = [Anime.placeholder]
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddFavouriteNilStorage() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageFake())
        
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveFavouriteSuccess() {
        initSystemUnderTest()
        
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected = true
        let actual = systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveFavouriteFailure() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageFake())
        
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected = false
        let actual = systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveFavourite() {
        initSystemUnderTest()
        
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        let _ = systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsFavouriteTrue() {
        initSystemUnderTest()
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
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
        
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        let _ = systemUnderTest?.resetFavourites()
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testResetFavouritesNilStorage() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageFake())
        
        let _ = systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        let _ = systemUnderTest?.resetFavourites()
        
        let expected: [Anime] = []
        let actual = systemUnderTest?.all
        
        XCTAssertEqual(expected, actual)
    }
    
    func testInitNilStorage() {
        initSystemUnderTest(storage: UnavailableFavouritesStorageFake())
    }
    
    private func initSystemUnderTest(storage: any DataStoring<String, Data> = FavouritesStorageFake()) {
        systemUnderTest = FavouritesManager(storage: storage)
    }
}
