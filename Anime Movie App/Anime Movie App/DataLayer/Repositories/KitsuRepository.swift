import UIKit

class KitsuRepository: AnimeRepository {
    private let dataProvider: DataProviding
    private let toAnimeMapper: any ToAnimeMapper<KitsuResult>
    private let imageRepository: ImageRepository
    private let favouritesManager: any FavouritesManaging
    
    var favourites: [Anime] {
        favouritesManager.all
    }
    
    init(dataProvider: DataProviding = KitsuProvider(), responseToAnimeMapper: any ToAnimeMapper<KitsuResult> = KitsuResultToAnimeMapper(), imageRepository: ImageRepository = ImageRepository(), favouritesManager: any FavouritesManaging = FavouritesManager()) {
        self.dataProvider = dataProvider
        self.toAnimeMapper = responseToAnimeMapper
        self.imageRepository = imageRepository
        self.favouritesManager = favouritesManager
    }
    
    func searchResults(for term: String, completion: @escaping (Result<AnimeRepository.SearchResultsType, LocalizedError>) -> ()) {
        dataProvider.search(for: term) { [weak self] result in
            switch result {
            case .success(let responseData):
                guard let anime = self?.decodeAndConvert(responseData, from: KitsuResponse.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success((term, anime)))
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
    
    func downloadImage(_ role: ImageRole, for anime: Anime, completion: @escaping (UIImage?) -> ()) {
        guard let imageURL = imageURL(of: anime, for: role) else {
            completion(UIImage(systemName: "popcorn.circle"))
            return
        }
        
        imageRepository.image(from: imageURL, for: anime) { anime, image in
            completion(image)
        }
    }
    
    func isFavourite(_ anime: Anime) -> Bool {
        favouritesManager.isFavourite(anime)
    }
    
    func toggleFavourite(_ anime: Anime) {
        guard !isFavourite(anime) else {
            let _ = favouritesManager.removeFavourite(anime, forKey: anime.key)
            return
        }
        
        let _ = favouritesManager.addFavourite(anime, forKey: anime.key)
    }

    private func imageURL(of anime: Anime, for role: ImageRole) -> NSURL? {
        switch role {
        case .cover:
            return anime.coverImageURL == nil ? nil : NSURL(string: anime.coverImageURL!)
        case .poster:
            return anime.posterImageURL == nil ? nil : NSURL(string: anime.posterImageURL!)
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
        
        return [toAnimeMapper.mapToAnime(from: kitsuResult)].compactMap { $0 }
    }
    
    private func convertToAnime(from response: KitsuResponse) -> [Anime] {
        guard let kitsuResults = response.data else {
            return []
        }
        
        let converted = kitsuResults.compactMap { kitsuResult in
            toAnimeMapper.mapToAnime(from: kitsuResult)
        }
        
        return converted
    }
}
