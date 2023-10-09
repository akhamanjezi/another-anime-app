import Foundation

// MARK: - KitsuImage
class KitsuImage: Codable {
    let tiny, large, small: String?
    let medium: String?
    let original: String?
    let meta: KitsuCoverImageMeta?

    init(tiny: String?, large: String?, small: String?, medium: String?, original: String?, meta: KitsuCoverImageMeta?) {
        self.tiny = tiny
        self.large = large
        self.small = small
        self.medium = medium
        self.original = original
        self.meta = meta
    }
}

// MARK: - KitsuCoverImageMeta
class KitsuCoverImageMeta: Codable {
    let dimensions: KitsuDimensions?

    init(dimensions: KitsuDimensions?) {
        self.dimensions = dimensions
    }
}

// MARK: - KitsuDimensions
class KitsuDimensions: Codable {
    let tiny, large, small, medium: Kitsu2D?

    init(tiny: Kitsu2D?, large: Kitsu2D?, small: Kitsu2D?, medium: Kitsu2D?) {
        self.tiny = tiny
        self.large = large
        self.small = small
        self.medium = medium
    }
}

// MARK: - Kitsu2D
class Kitsu2D: Codable {
    let width, height: Int?

    init(width: Int?, height: Int?) {
        self.width = width
        self.height = height
    }
}
