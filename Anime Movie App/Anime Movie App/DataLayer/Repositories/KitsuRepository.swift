import Foundation

class KitsuRepository: AnimeRepository {
    private let dataProvider: DataProviding
    private let responseToAnimeMapper: ResponseToAnimeMapper<KitsuResult>
    
    init(dataProvider: DataProviding = KitsuProvider(), responseToAnimeMapper: ResponseToAnimeMapper<KitsuResult> = KitsuResultToAnimeMapper()) {
        self.dataProvider = dataProvider
        self.responseToAnimeMapper = responseToAnimeMapper
    }
    
    func searchResults(for term: String, completion: @escaping (Result<[Anime], LocalizedError>) -> ()) {
        dataProvider.search(for: term) { [weak self] result in
            switch result {
            case .success(let dataResponse):
                guard let anime = self?.decodeAndConvertResponse(for: dataResponse) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(anime))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decodeAndConvertResponse(for dataResponse: Data) -> [Anime]? {
        guard let kitsuResponse = try? JSONDecoder().decode(KitsuResponse.self, from: dataResponse) else {
            return nil
        }
        
        return convertToAnime(from: kitsuResponse)
    }
    
    private func convertToAnime(from response: KitsuResponse) -> [Anime] {
        let converted = (response.data ?? []).compactMap { kitsuResult in
            responseToAnimeMapper.mapToAnime(from: kitsuResult)
        }
        
        return converted
    }
}
