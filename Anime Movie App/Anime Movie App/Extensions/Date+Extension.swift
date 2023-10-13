import Foundation

extension Date {
    func toStringAnimeDateStyle() -> String {
        return self.formatted(.dateTime
                .day(.twoDigits)
                .month(.wide)
                .year(.extended())
                .locale(.current))
    }
}
