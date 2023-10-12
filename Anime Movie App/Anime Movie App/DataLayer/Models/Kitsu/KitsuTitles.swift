import Foundation

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
