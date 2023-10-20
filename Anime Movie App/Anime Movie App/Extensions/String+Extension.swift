import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter.shared
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
    
    func withDoubleLineBreaks(trim: Bool = true) -> Self {
        guard let stringWithDoubleLineBreaks = try? self.replacing(Regex("\n+"), with: "\n\n") else {
            return trim
            ? self.trimmingCharacters(in: .whitespacesAndNewlines)
            : self
        }
        return trim
        ? stringWithDoubleLineBreaks.trimmingCharacters(in: .whitespacesAndNewlines)
        : stringWithDoubleLineBreaks
    }
}
