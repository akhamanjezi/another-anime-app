import Foundation

class KitsuRespository: AnimeRepository {
    let dataProvider: DataProvider
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getSearchResults(for searchTerm: String, completion: @escaping ([Anime]?) -> ()) {
        dataProvider.search(for: searchTerm) { result in
            switch result {
            case .success(let dataResponse):
                if let kitsuResponse = try? JSONDecoder().decode(KitsuResponse.self, from: dataResponse) {
                    let anime = self.convertToAnime(from: kitsuResponse)
                    completion(anime)
                } else {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func convertToAnime(from response: KitsuResponse) -> [Anime] {
        let converted = (response.data ?? []).compactMap { result in
            getAnime(from: result)
        }
        
        return converted
    }
    
    func getAnime(from kitsu: KitsuResult) -> Anime? {
        
        guard let attributes = kitsu.attributes else {
            return nil
        }
        
        return Anime(title: attributes.canonicalTitle,
                     genres: nil,
                     releaseDate: attributes.createdAt?.toDate(),
                     averageRating: attributes.averageRating,
                     ageRating: attributes.ageRating,
                     imageURL: attributes.posterImage?.original,
                     thumnail: nil,
                     duration: .seconds(60) * (attributes.totalLength ?? 0),
                     externalID: kitsu.id,
                     source: .kitsu
        )
    }
}
