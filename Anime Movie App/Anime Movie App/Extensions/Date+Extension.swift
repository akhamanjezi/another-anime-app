import Foundation

extension Date {
    func toStringAnimeDateStyle() -> String {
        return self.formatted(.dateTime
                .day(.defaultDigits)
                .month(.wide)
                .year(.extended())
                .locale(.current))
    }
}
