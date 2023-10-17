import Foundation
import UIKit

protocol ImageDownloading {
    func downloadImage(from url: NSURL, completion: @escaping (Result<UIImage, LocalizedError>) -> ())
}
