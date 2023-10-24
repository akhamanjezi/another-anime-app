import Foundation

extension DateComponentsFormatter {
    static let sharedBrief = DateComponentsFormatter(unitsStyle: .brief)
    
    private convenience init(unitsStyle: DateComponentsFormatter.UnitsStyle) {
        self.init()
        self.unitsStyle = unitsStyle
    }
}
