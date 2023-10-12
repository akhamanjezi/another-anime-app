import XCTest

final class HomeViewModelTests: XCTestCase {
    private func searchHomeViewModelWith(repositoryFile named: String) -> ([Anime], LocalizedError?) {
        let filePath = Bundle(for: Anime_Movie_AppTests.self).url(forResource: named, withExtension: "json")?.path(percentEncoded: false) ?? ""

        let mockDP = MockDataProvider(resourcePath: filePath)
        let kitsuRepo = KitsuRepository(dataProvider: mockDP)
        let homeViewModel = HomeViewModel(animeRepository: kitsuRepo)
        
        homeViewModel.search(for: "")
        
        return (homeViewModel.animeSearchResults.value, homeViewModel.searchingError.value)
    }
    
    func testSuccessfulCallWithNotNullData() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(repositoryFile: "spirited_away")
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(animeSearchResults.count, 3)
    }
    
    func testSuccessfulCallWithNullData() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(repositoryFile: "null")

        XCTAssertNotNil(searchingError)
        XCTAssertEqual(animeSearchResults.count, 0)
    }
    
    func testSuccessfulAnimeReturn() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(repositoryFile: "spirited_away")
        
        XCTAssertNil(searchingError)
        
        let testData = AnimeTestDataProvider.validAnimeInstance

        if animeSearchResults.count > 0 {
            XCTAssertEqual(animeSearchResults[0], testData)
        } else {
            XCTFail("Unexpected empty anime result")
        }
    }
    
    func testSuccessfulAnimeReturnNoResults() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(repositoryFile: "not_an_anime")
        
        XCTAssertNil(searchingError)
        XCTAssertEqual(animeSearchResults.count, 0)
    }
    
    func testUnsuccessfulCall() throws {
        let (animeSearchResults, searchingError) = searchHomeViewModelWith(repositoryFile: "")
        
        XCTAssertNotNil(searchingError)
        XCTAssertEqual(animeSearchResults.count, 0)
    }
}
