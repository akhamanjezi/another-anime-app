import Foundation

class KitsuRepository: AnimeRepository {
    private let dataProvider: DataProviding
    private let responseToAnimeMapper: any ResponseToAnimeMapper<KitsuResult>
    
    init(dataProvider: DataProviding = KitsuProvider(), responseToAnimeMapper: any ResponseToAnimeMapper<KitsuResult> = KitsuResultToAnimeMapper()) {
        self.dataProvider = dataProvider
        self.responseToAnimeMapper = responseToAnimeMapper
    }
    
    func searchResults(for term: String, completion: @escaping (Result<[Anime], LocalizedError>) -> ()) {
        dataProvider.search(for: term) { [weak self] result in
            switch result {
            case .success(let dataResponse):
                guard let anime = self?.decodeAndConvertResponse(for: dataResponse, from: KitsuResponse.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(anime))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func anime(by id: String, completion: @escaping (Result<Anime?, LocalizedError>) -> ()) {
        dataProvider.getAnime(by: id) { [weak self] result in
            switch result {
            case .success(let dataResponse):
                guard let anime = self?.decodeAndConvertResponse(for: dataResponse, from: KitsuResponseSingle.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                completion(.success(anime[safe: 0]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decodeAndConvertResponse<T>(for dataResponse: Data, from type: T.Type) -> [Anime]? where T : Decodable {
        guard let kitsuResponse = try? JSONDecoder().decode(T.self, from: dataResponse) else {
            return nil
        }
        
        switch kitsuResponse {
        case is KitsuResponseSingle:
            guard let kitsuResult = (kitsuResponse as! KitsuResponseSingle).data else {
                return nil
            }
                        
            return [responseToAnimeMapper.mapToAnime(from: kitsuResult)].compactMap { $0 }
        default:
            return convertToAnime(from: kitsuResponse as! KitsuResponse)
        }
    }
    
    private func convertToAnime(from response: KitsuResponse) -> [Anime] {
        let converted = (response.data ?? []).compactMap { kitsuResult in
            responseToAnimeMapper.mapToAnime(from: kitsuResult)
        }
        
        return converted
    }
}
