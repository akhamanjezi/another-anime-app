import XCTest

final class KitsuRepositoryTests: XCTestCase {
    private func getRepositoryWith(file named: String) -> AnimeRepository {
        let filePath = Bundle(for: Anime_Movie_AppTests.self).url(forResource: named, withExtension: "json")?.path(percentEncoded: false) ?? ""

        let mockDP = MockDataProvider(resourcePath: filePath)
        return KitsuRespository(dataProvider: mockDP)
    }
    
    func testSuccessfulCallWithNotNullData() throws {
        let kitsuRepository = getRepositoryWith(file: "spirited_away")
        
        kitsuRepository.getSearchResults(for: "") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testSuccessfulCallWithNullData() throws {
        let kitsuRepository = getRepositoryWith(file: "null")
                
        kitsuRepository.getSearchResults(for: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let error):
                XCTAssert(error == .invalidResponse)
            }
        }
    }
    
    func testSuccessfulAnimeReturn() throws {
        let kitsuRepository = getRepositoryWith(file: "spirited_away")
        
        kitsuRepository.getSearchResults(for: "") { result in
            switch result {
            case .success(let data):
                let testData = Anime.testData()[0]
                XCTAssertEqual(data[0], testData)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testSuccessfulAnimeReturnNoResults() throws {
        let kitsuRepository = getRepositoryWith(file: "not_an_anime")
        
        kitsuRepository.getSearchResults(for: "") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 0)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testUnSuccessfulCall() throws {
        let kitsuRepository = getRepositoryWith(file: "")
                
        kitsuRepository.getSearchResults(for: "") { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected successful call")
            case .failure(let error):
                XCTAssert(error == .invalidRequest)
            }
        }
    }
}
