import XCTest

final class KitsuResultToAnimeMapperTests: XCTestCase {
    func getMappedAnimeFromTestKitsuResult(at idx: Int) -> Anime? {
        let animeMapper = KitsuResultToAnimeMapper()
        let testKitsuResultData = KitsuResult.testData()[idx]
        
        return animeMapper.mapToAnime(from: testKitsuResultData)
    }
    
    func testSuccessfulKitsuMapToAnime() throws {
        let testKitsuResultData = KitsuResult.testData()[0]
        let testAnimeData = Anime.testData()[0]
        
        let mappedKitsu = getMappedAnimeFromTestKitsuResult(at: 0)
        
        XCTAssert(type(of: testKitsuResultData) != type(of: testAnimeData))
        XCTAssertEqual(mappedKitsu, testAnimeData)
    }
    
    func testUnsccessfulKitsuMapToAnime() throws {
        let mappedKitsu = getMappedAnimeFromTestKitsuResult(at: 1)
        
        XCTAssertNil(mappedKitsu)
    }
}
