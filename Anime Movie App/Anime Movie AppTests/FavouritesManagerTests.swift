import XCTest

final class FavouritesManagerTests: XCTestCase {
    private var systemUnderTest: FavouritesManager? = nil
    private let animeForTest = AnimeTestDataProvider.validAnimeInstance
    
    override func setUpWithError() throws {
        systemUnderTest = FavouritesManager(storage: TestDataStorage())
    }
    
    override func tearDownWithError() throws {
        systemUnderTest = nil
    }
    
    func testAddFavourite() {
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        let actual = systemUnderTest?.all
        
        let expected = [Anime.placeholder]
        
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveFavourite() {
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        systemUnderTest?.removeFavourite(Anime.placeholder, forKey: "favourite")
        
        let actual = systemUnderTest?.all
        let expected: [Anime] = []
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsFavouriteTrue() {
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        
        let actual = systemUnderTest?.isFavourite(Anime.placeholder)
        let expected = true
        
        XCTAssertEqual(expected, actual)
    }
    
    func testIsFavouriteFalse() {
        let actual = systemUnderTest?.isFavourite(Anime.placeholder)
        let expected = false
        
        XCTAssertEqual(expected, actual)
    }
    
    func testResetFavourites() {
        systemUnderTest?.addFavourite(Anime.placeholder, forKey: "favourite")
        systemUnderTest?.resetFavourites()
        
        let actual = systemUnderTest?.all
        let expected: [Anime] = []
        
        XCTAssertEqual(expected, actual)
    }
}
