import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date? {
        let dateFormatter = DateFormatter.shared
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: self)

        return date
    }
}
