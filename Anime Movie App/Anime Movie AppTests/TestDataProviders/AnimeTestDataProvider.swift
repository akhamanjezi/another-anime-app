import Foundation

class AnimeTestDataProvider {
    static let validAnimeInstance = Anime(title: "Spirited Away",
                                          genres: nil,
                                          releaseDate: "2001-07-20".toDate(),
                                          synopsis: "Stubborn, spoiled, and naïve, 10-year-old Chihiro Ogino is less than pleased when she and her parents discover an abandoned amusement park on the way to their new house. Cautiously venturing inside, she realizes that there is more to this place than meets the eye, as strange things begin to happen once dusk falls. Ghostly apparitions and food that turns her parents into pigs are just the start—Chihiro has unwittingly crossed over into the spirit world. Now trapped, she must summon the courage to live and work amongst spirits, with the help of the enigmatic Haku and the cast of unique characters she meets along the way.\nVivid and intriguing, Sen to Chihiro no Kamikakushi tells the story of Chihiro's journey through an unfamiliar world as she strives to save her parents and return home.\n[Written by MAL Rewrite]",
                                          averageRating: 82.59,
                                          ageRating: "G",
                                          imageURL: "https://media.kitsu.io/anime/poster_images/176/original.jpg",
                                          thumnail: nil,
                                          duration: .seconds(60) * 125,
                                          externalID: "176",
                                          source: .kitsu)
    
    static let validKitsuResult = KitsuResult(id: "176",
                                              type: nil,
                                              links: nil,
                                              attributes: KitsuAttributes(createdAt: nil,
                                                                          updatedAt: nil,
                                                                          slug: nil,
                                                                          synopsis: "Stubborn, spoiled, and naïve, 10-year-old Chihiro Ogino is less than pleased when she and her parents discover an abandoned amusement park on the way to their new house. Cautiously venturing inside, she realizes that there is more to this place than meets the eye, as strange things begin to happen once dusk falls. Ghostly apparitions and food that turns her parents into pigs are just the start—Chihiro has unwittingly crossed over into the spirit world. Now trapped, she must summon the courage to live and work amongst spirits, with the help of the enigmatic Haku and the cast of unique characters she meets along the way.\nVivid and intriguing, Sen to Chihiro no Kamikakushi tells the story of Chihiro's journey through an unfamiliar world as she strives to save her parents and return home.\n[Written by MAL Rewrite]",
                                                                          description: nil,
                                                                          coverImageTopOffset: nil,
                                                                          titles: nil,
                                                                          canonicalTitle: "Spirited Away",
                                                                          abbreviatedTitles: nil,
                                                                          averageRating: "82.59",
                                                                          ratingFrequencies: nil,
                                                                          userCount: nil,
                                                                          favoritesCount: nil,
                                                                          startDate: "2001-07-20",
                                                                          endDate: nil,
                                                                          nextRelease: nil,
                                                                          popularityRank: nil,
                                                                          ratingRank: nil,
                                                                          ageRating: "G",
                                                                          ageRatingGuide: nil,
                                                                          subtype: nil,
                                                                          status: nil,
                                                                          tba: nil,
                                                                          posterImage: KitsuImage(tiny: nil,
                                                                                                  large: nil,
                                                                                                  small: nil,
                                                                                                  medium: nil,
                                                                                                  original: "https://media.kitsu.io/anime/poster_images/176/original.jpg",
                                                                                                  meta: nil),
                                                                          coverImage: nil,
                                                                          episodeCount: nil,
                                                                          episodeLength: nil,
                                                                          totalLength: 125,
                                                                          youtubeVideoID: nil,
                                                                          showType: nil,
                                                                          nsfw: nil),
                                              relationships: nil)
    
    static let invalidKitsuResult = KitsuResult(id: "176",
                                                type: nil,
                                                links: nil,
                                                attributes: nil,
                                                relationships: nil)
    
    static let successfulKitsuSearchDataProvider = DataProviderStub(resourcePath: Bundle(for: Anime_Movie_AppTests.self).url(forResource: "search_spirited_away", withExtension: "json")?.path(percentEncoded: false) ?? "")
    
    static let nullKitsuDataProvider = DataProviderStub(resourcePath: Bundle(for: Anime_Movie_AppTests.self).url(forResource: "null", withExtension: "json")?.path(percentEncoded: false) ?? "")
    
    static let successfulNoResultKitsuSearchDataProvider = DataProviderStub(resourcePath: Bundle(for: Anime_Movie_AppTests.self).url(forResource: "search_not_an_anime", withExtension: "json")?.path(percentEncoded: false) ?? "")
    
    static let unsuccessfulKitsuDataProvider = DataProviderStub(resourcePath: Bundle(for: Anime_Movie_AppTests.self).url(forResource: "", withExtension: "json")?.path(percentEncoded: false) ?? "")
    
    static let successfulKitsuAnimeByIDDataProvider = DataProviderStub(resourcePath: Bundle(for: Anime_Movie_AppTests.self).url(forResource: "get_spirited_away", withExtension: "json")?.path(percentEncoded: false) ?? "")
        
    static let successfulNoResultKitsuAnimeByIDDataProvider = DataProviderStub(resourcePath: Bundle(for: Anime_Movie_AppTests.self).url(forResource: "get_no_result", withExtension: "json")?.path(percentEncoded: false) ?? "")
}
