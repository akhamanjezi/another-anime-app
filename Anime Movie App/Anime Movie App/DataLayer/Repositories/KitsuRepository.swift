import UIKit

class KitsuRepository: AnimeRepository {
    private let dataProvider: DataProviding
    private let responseToAnimeMapper: any ResponseToAnimeMapper<KitsuResult>
    private let imageRepository: ImageRepository
    
    init(dataProvider: DataProviding = KitsuProvider(), responseToAnimeMapper: any ResponseToAnimeMapper<KitsuResult> = KitsuResultToAnimeMapper(), imageRepository: ImageRepository = ImageRepository()) {
        self.dataProvider = dataProvider
        self.responseToAnimeMapper = responseToAnimeMapper
        self.imageRepository = imageRepository
    }
    
    func searchResults(for term: String, completion: @escaping (Result<[Anime], LocalizedError>) -> ()) {
        dataProvider.search(for: term) { [weak self] result in
            switch result {
            case .success(let responseData):
                guard let anime = self?.decodeAndConvert(responseData, from: KitsuResponse.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(anime))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func anime(by id: String, completion: @escaping (Result<Anime, LocalizedError>) -> ()) {
        dataProvider.getAnime(by: id) { [weak self] result in
            switch result {
            case .success(let responseData):
                self?.handleSearchSuccess(for: responseData) { result in
                    completion(result)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(for anime: Anime, completion: @escaping (UIImage?) -> ()) {
        guard let imageURL = anime.coverImageURL, let imageURL = NSURL(string: imageURL) else {
            completion(UIImage(systemName: "popcorn.circle"))
            return
        }
        
        imageRepository.image(from: imageURL, for: anime) { anime, image in
            completion(image)
        }
    }
    
    private func handleSearchSuccess(for responseData: Data, completion: @escaping (Result<Anime, LocalizedError>) -> ()) {
        guard let animeArray = decodeAndConvert(responseData, from: KitsuResponseSingle.self),
              let anime = animeArray[safe: 0] else {
            completion(.failure(.invalidResponse))
            return
        }
        
        completion(.success(anime))
    }
    
    private func decodeAndConvert<T>(_ responseData: Data, from type: T.Type) -> [Anime]? where T : Decodable {
        guard let kitsuResponse = try? JSONDecoder().decode(T.self, from: responseData) else {
            return nil
        }
        
        switch kitsuResponse {
        case is KitsuResponseSingle:
            return convertToAnime(from: kitsuResponse as! KitsuResponseSingle)
        default:
            return convertToAnime(from: kitsuResponse as! KitsuResponse)
        }
    }
    
    private func convertToAnime(from response: KitsuResponseSingle) -> [Anime] {
        guard let kitsuResult = response.data else {
            return []
        }
        
        return [responseToAnimeMapper.mapToAnime(from: kitsuResult)].compactMap { $0 }
    }
    
    private func convertToAnime(from response: KitsuResponse) -> [Anime] {
        let converted = (response.data ?? []).compactMap { kitsuResult in
            responseToAnimeMapper.mapToAnime(from: kitsuResult)
        }
        
        return converted
    }
}
