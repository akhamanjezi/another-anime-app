import Foundation

class KitsuRespository: AnimeRepository {
    private let dataProvider: DataProvider
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getSearchResults(for term: String, completion: @escaping (Result<[Anime], LocalizedError>) -> ()) {
        dataProvider.search(for: term) { result in
            switch result {
            case .success(let dataResponse):
                if let kitsuResponse = try? JSONDecoder().decode(KitsuResponse.self, from: dataResponse) {
                    let anime = self.convertToAnime(from: kitsuResponse)
                    completion(.success(anime))
                } else {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func convertToAnime(from response: KitsuResponse) -> [Anime] {
        let converted = (response.data ?? []).compactMap { kitsuResult in
            getAnime(from: kitsuResult)
        }
        
        return converted
    }
    
    private func getAnime(from kitsu: KitsuResult) -> Anime? {
        
        guard let attributes = kitsu.attributes else {
            return nil
        }
        
        return Anime(title: attributes.canonicalTitle,
                     genres: nil,
                     releaseDate: attributes.startDate?.toDate(),
                     synopsis: attributes.synopsis,
                     averageRating: attributes.averageRating != nil ? Double(attributes.averageRating!) : nil,
                     ageRating: attributes.ageRating,
                     imageURL: attributes.posterImage?.original,
                     thumnail: nil,
                     duration: .seconds(60) * (attributes.totalLength ?? 0),
                     externalID: kitsu.id,
                     source: .kitsu
        )
    }
}
