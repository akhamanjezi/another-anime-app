import UIKit

protocol ImageRepository {
    func image(from url: NSURL, for anime: Anime, completion: @escaping (Anime, UIImage?) -> ())
}
