import Foundation

class KitsuRelationship: Codable {
    let links: KitsuRelationshipLinks?

    init(links: KitsuRelationshipLinks?) {
        self.links = links
    }
}

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
