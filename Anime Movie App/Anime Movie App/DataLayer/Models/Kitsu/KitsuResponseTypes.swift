import Foundation

class KitsuResponse: Codable {
    let data: [KitsuResult]?
    let meta: KitsuResponseMeta?
    let links: KitsuResponseLinks?

    init(data: [KitsuResult]?, meta: KitsuResponseMeta?, links: KitsuResponseLinks?) {
        self.data = data
        self.meta = meta
        self.links = links
    }
}

class KitsuResponseLinks: Codable {
    let first, next, last: String?

    init(first: String?, next: String?, last: String?) {
        self.first = first
        self.next = next
        self.last = last
    }
}

class KitsuResponseMeta: Codable {
    let count: Int?

    init(count: Int?) {
        self.count = count
    }
}
