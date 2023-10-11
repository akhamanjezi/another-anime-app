import Foundation

class KitsuResult: Codable {
    let id, type: String?
    let links: KitsuResultLinks?
    let attributes: KitsuAttributes?
    let relationships: [String: KitsuRelationship]?

    init(id: String?, type: String?, links: KitsuResultLinks?, attributes: KitsuAttributes?, relationships: [String: KitsuRelationship]?) {
        self.id = id
        self.type = type
        self.links = links
        self.attributes = attributes
        self.relationships = relationships
    }
}
