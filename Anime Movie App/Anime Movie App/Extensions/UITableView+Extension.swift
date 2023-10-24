import UIKit

extension UITableView {
    func registerNib(named name: String, bundle: Bundle? = nil) {
        let tableViewCell = UINib(nibName: name, bundle: bundle)
        register(tableViewCell, forCellReuseIdentifier: name)
    }
}
