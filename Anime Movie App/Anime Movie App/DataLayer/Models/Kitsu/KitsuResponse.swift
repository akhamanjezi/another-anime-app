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
