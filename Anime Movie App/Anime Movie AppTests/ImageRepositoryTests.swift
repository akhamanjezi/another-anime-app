import XCTest

final class ImageRepositoryTests: XCTestCase {
    private let systemUnderTest = ImageRepository(imageDownloder: ImageDownloaderStub())
    private let animeForTest = AnimeTestDataProvider.validAnimeInstance
    
    func testSuccessfulPosterImageDownload() throws {
        let expected = AnimeTestDataProvider.spiritedAwayPosterImage
        
        guard let imageURL = animeForTest.posterImageURL, let imageURL = NSURL(string: imageURL) else {
            return
        }
        
        systemUnderTest.image(from: imageURL, for: animeForTest) { anime, image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testSuccessfulCoverImageDownload() throws {
        let expected = AnimeTestDataProvider.spiritedAwayCoverImage
        
        guard let imageURL = AnimeTestDataProvider.validAnimeInstance.coverImageURL, let imageURL = NSURL(string: imageURL) else {
            return
        }
        
        systemUnderTest.image(from: imageURL, for: animeForTest) { anime, image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testUnsuccessfulImageDownload() throws {
        let expected = UIImage(systemName: "popcorn.circle")
        
        systemUnderTest.image(from: NSURL(), for: animeForTest) { anime, image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
}
