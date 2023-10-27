import XCTest

final class ImageRepositoryTests: XCTestCase {
    private let systemUnderTest = ImageRepo(imageDownloader: ImageDownloaderStub())
    private let animeForTest = AnimeTestDataProvider.validAnimeInstance
    
    func testSuccessfulPosterImageDownload() {
        let expected = AnimeTestDataProvider.spiritedAwayPosterImage
        
        guard let imageURL = animeForTest.posterImageURL, let imageURL = NSURL(string: imageURL) else {
            XCTFail("Could not init NSURL")
            return
        }
        
        systemUnderTest.image(from: imageURL, for: animeForTest) { anime, image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testSuccessfulCoverImageDownload() {
        let expected = AnimeTestDataProvider.spiritedAwayCoverImage
        
        guard let imageURL = AnimeTestDataProvider.validAnimeInstance.coverImageURL, let imageURL = NSURL(string: imageURL) else {
            XCTFail("Could not init NSURL")
            return
        }
        
        systemUnderTest.image(from: imageURL, for: animeForTest) { anime, image in
            let actual = image
            XCTAssertEqual(expected, actual)
        }
    }
    
    func testUnsuccessfulImageDownload() {
        let expected = UIImage(systemName: "popcorn.circle")
        
        systemUnderTest.image(from: NSURL(), for: animeForTest) { anime, image in
            let actual = image
            XCTAssertNil(actual)
        }
    }
}
