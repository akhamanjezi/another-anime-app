import Foundation

class HomeViewModel {
    
    func newFeatureAnime(completion: @escaping (Anime) -> ()) {
        completion(Anime(title: "Spirited Away",
                     genres: nil,
                     releaseDate: "2001-07-20".toDate(),
                     synopsis: "Stubborn, spoiled, and naïve, 10-year-old Chihiro Ogino is less than pleased when she and her parents discover an abandoned amusement park on the way to their new house. Cautiously venturing inside, she realizes that there is more to this place than meets the eye, as strange things begin to happen once dusk falls. Ghostly apparitions and food that turns her parents into pigs are just the start—Chihiro has unwittingly crossed over into the spirit world. Now trapped, she must summon the courage to live and work amongst spirits, with the help of the enigmatic Haku and the cast of unique characters she meets along the way.\nVivid and intriguing, Sen to Chihiro no Kamikakushi tells the story of Chihiro's journey through an unfamiliar world as she strives to save her parents and return home.\n[Written by MAL Rewrite]",
                     averageRating: 82.59,
                     ageRating: "G",
                     imageURL: "https://media.kitsu.io/anime/poster_images/176/original.jpg",
                     thumnail: nil,
                     duration: .seconds(60) * 125,
                     externalID: "176",
                     source: .kitsu))
    }
}
