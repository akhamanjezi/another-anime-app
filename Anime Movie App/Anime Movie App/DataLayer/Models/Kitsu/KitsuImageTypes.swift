import Foundation

class KitsuImage: Codable {
    let tiny, large, small: String?
    let medium: String?
    let original: String?
    let meta: KitsuImageMeta?

    init(tiny: String?, large: String?, small: String?, medium: String?, original: String?, meta: KitsuImageMeta?) {
        self.tiny = tiny
        self.large = large
        self.small = small
        self.medium = medium
        self.original = original
        self.meta = meta
    }
}

class KitsuImageMeta: Codable {
    let dimensions: KitsuImageDimensions?

    init(dimensions: KitsuImageDimensions?) {
        self.dimensions = dimensions
    }
}

class KitsuImageDimensions: Codable {
    let tiny, large, small, medium: KitsuImage2D?

    init(tiny: KitsuImage2D?, large: KitsuImage2D?, small: KitsuImage2D?, medium: KitsuImage2D?) {
        self.tiny = tiny
        self.large = large
        self.small = small
        self.medium = medium
    }
}

class KitsuImage2D: Codable {
    let width, height: Int?

    init(width: Int?, height: Int?) {
        self.width = width
        self.height = height
    }
}
