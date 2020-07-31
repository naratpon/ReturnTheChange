import UIKit

extension UITableView {
    func register(reuseNib: String) {
        self.register(UINib.init(nibName: reuseNib, bundle: .main), forCellReuseIdentifier: reuseNib)
    }
}
