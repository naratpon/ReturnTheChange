import UIKit

class DetailReturnMoneyTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(value: String, amount: String) {
        self.valueLabel.text = value
        self.amountLabel.text = amount
    }
    
}
