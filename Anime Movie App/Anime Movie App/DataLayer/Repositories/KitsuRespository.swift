import Foundation

class KitsuRespository: AnimeRepository {
    private let dataProvider: DataProviding
    private let responseToAnimeMapper: ResponseToAnimeMapper<KitsuResult>
    
    init(dataProvider: DataProviding, responseToAnimeMapper: ResponseToAnimeMapper<KitsuResult>) {
        self.dataProvider = dataProvider
        self.responseToAnimeMapper = responseToAnimeMapper
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
            responseToAnimeMapper.mapToAnime(from: kitsuResult)
        }
        
        return converted
    }
}
