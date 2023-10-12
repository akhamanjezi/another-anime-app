import XCTest

final class KitsuRepositoryTests: XCTestCase {
    private var systemUnderTest: KitsuRepository? = nil
        
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    private func initSystemUnderTest(dataProvider: DataProviding) {
        systemUnderTest = KitsuRepository(dataProvider: dataProvider)
        XCTAssertNotNil(systemUnderTest)
    }
    
    func testSuccessfulCallWithNotNullData() throws {
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
    
    func testSuccessfulCallWithNullData() throws {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.nullKitsuSearchDataProvider)
        
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
    
    func testSuccessfulAnimeReturn() throws {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulKitsuSearchDataProvider)
        
        let expected = AnimeTestDataProvider.validAnimeInstance
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(let data):
                let actual = data[0]
                XCTAssertEqual(expected, actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testSuccessfulAnimeReturnNoResults() throws {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.successfulNoResultKitsuSearchDataProvider)
        
        let expected = 0
        
        systemUnderTest?.searchResults(for: "") { result in
            switch result {
            case .success(let data):
                let actual = data.count
                XCTAssertEqual(expected, actual)
            case .failure(_):
                XCTFail("Unexpected unsuccessful call")
            }
        }
    }
    
    func testUnSuccessfulCall() throws {
        initSystemUnderTest(dataProvider: AnimeTestDataProvider.unsuccessfulKitsuSearchDataProvider)
        
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
}
