import Foundation

// MARK: - KitsuTitles
class KitsuTitles: Codable {
    let en, enJp, enUs, jaJp: String?

    enum CodingKeys: String, CodingKey {
        case en
        case enJp = "en_jp"
        case enUs = "en_us"
        case jaJp = "ja_jp"
    }

    init(en: String?, enJp: String?, enUs: String?, jaJp: String?) {
        self.en = en
        self.enJp = enJp
        self.enUs = enUs
        self.jaJp = jaJp
    }
}

// MARK: - KitsuResultLinks
class KitsuResultLinks: Codable {
    let linksSelf: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }

    init(linksSelf: String?) {
        self.linksSelf = linksSelf
    }
}

// MARK: - KitsuRelationship
class KitsuRelationship: Codable {
    let links: KitsuRelationshipLinks?

    init(links: KitsuRelationshipLinks?) {
        self.links = links
    }
}


// MARK: - KitsuRelationshipLinks
class KitsuRelationshipLinks: Codable {
    let linksSelf, related: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case related
    }

    init(linksSelf: String?, related: String?) {
        self.linksSelf = linksSelf
        self.related = related
    }
}

// MARK: - KitsuResponseLinks
class KitsuResponseLinks: Codable {
    let first, next, last: String?

    init(first: String?, next: String?, last: String?) {
        self.first = first
        self.next = next
        self.last = last
    }
}

// MARK: - KitsuResponseMeta
class KitsuResponseMeta: Codable {
    let count: Int?

    init(count: Int?) {
        self.count = count
    }
}
