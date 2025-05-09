import Foundation

extension Date {
    func toHumanReadableDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }

    func toHumanReadableDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy, HH:mm"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
